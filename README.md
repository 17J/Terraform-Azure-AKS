# 🚀 Terraform AKS Cluster on Azure (Professional Guide)

This guide provides a complete, production-ready method to provision an **Azure Kubernetes Service (AKS)** cluster using **Terraform**.

## 🛠️ Prerequisites

Ensure the following tools are installed (commands provided for Ubuntu/Debian-based systems):

### 1. Azure CLI

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az --version
```

### 2. kubectl

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
```

### 3. Terraform

```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
terraform -version
```

## 🔐 Authentication – Service Principal (Best Practice for Automation)

```bash
az ad sp create-for-rbac \
  --name "terraform-aks-sp-$(date +%s)" \
  --role Contributor \
  --scopes /subscriptions/$(az account show --query id -o tsv)
```

**Save the output**:

```json
{
  "appId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "displayName": "...",
  "password": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "tenant": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}
```

Set these as environment variables (or in `.env` / CI/CD pipeline):

```bash
export ARM_CLIENT_ID="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
export ARM_CLIENT_SECRET="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export ARM_SUBSCRIPTION_ID="$(az account show --query id -o tsv)"
export ARM_TENANT_ID="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
```

Terraform will now authenticate automatically.

## 🧪 Deployment Steps

### 1. Generate SSH Key (for node access — optional but recommended)

```bash
ssh-keygen -t rsa -b 4096 \
  -f ~/.ssh/aks_node_key \
  -N "" \
  -C "terraform@aks-$(date +%Y%m)"
```

### 2. Navigate to Project Directory and Initialize Terraform

```bash
cd TERRAFORM-AZURE-AKS
terraform init
```

**Pro Tip:** For real projects, use a remote backend (Azure Blob Storage recommended):

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstateunique"
    container_name       = "tfstate"
    key                  = "aks-cluster.terraform.tfstate"
  }
}
```

### 3. Validate and Plan

```bash
terraform validate
terraform plan -out=aks.tfplan
```

### 4. Apply – Deploy the Cluster

```bash
terraform apply aks.tfplan
```

→ Expected time: 10–20 minutes (depends on node count and region)

## ✅ Post-Deployment: Connect to the Cluster

Fetch credentials and verify connectivity:

```bash
# Update resource group and cluster name based on your Terraform variables / outputs
az aks get-credentials \
  --resource-group my-aks-rg \
  --name my-aks-cluster \
  --admin   # optional — retrieves admin credentials

kubectl get nodes
kubectl get pods --all-namespaces
```

## 🧹 Cleanup

```bash
terraform destroy --auto-approve
```
