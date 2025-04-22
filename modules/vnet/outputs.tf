# modules/vnet/outputs.tf
output "subnet_id" {
  description = "Subnet ID for AKS node pool"
  value       = azurerm_subnet.aks.id
}