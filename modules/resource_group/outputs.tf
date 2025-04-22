
# modules/resource_group/outputs.tf
output "name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.this.name
}