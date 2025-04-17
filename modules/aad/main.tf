resource "azuread_group" "aks_admins" {
  display_name = "aks-admins"
  security_enabled = true
}

resource "azuread_application" "aks_server" {
  display_name = "aks-server"
}

resource "azuread_service_principal" "aks_server_sp" {
  application_id = azuread_application.aks_server.application_id
}

resource "azuread_application_password" "aks_server_password" {
  application_object_id = azuread_application.aks_server.object_id
  value                 = "ChangeThisPassword123!"
  end_date_relative     = "8760h"
}

resource "azuread_application" "aks_client" {
  display_name = "aks-client"
}

