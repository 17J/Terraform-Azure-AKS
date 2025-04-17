output "admin_group_object_id" {
  value = azuread_group.aks_admins.object_id
}

output "client_app_id" {
  value = azuread_application.aks_client.application_id
}

output "server_app_id" {
  value = azuread_application.aks_server.application_id
}

output "server_app_secret" {
  value = azuread_application_password.aks_server_password.value
}
