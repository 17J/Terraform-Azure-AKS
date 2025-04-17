resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.cluster_name}-dns"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_DS2_v2"
    vnet_subnet_id  = var.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  azure_active_directory_role_based_access_control {
    managed                = true
    admin_group_object_ids = [var.aad_admin_group_object_id]
    azure_rbac_enabled     = true
  }

  oidc_issuer_enabled = true

  aad_profile {
    managed           = true
    client_app_id     = var.client_app_id
    server_app_id     = var.server_app_id
    server_app_secret = var.server_app_secret
    tenant_id         = var.tenant_id
  }

  api_server_authorized_ip_ranges = ["0.0.0.0/0"]

  tags = {
    Environment = "Dev"
  }
}
