# modules/aad/main.tf
resource "azuread_group" "aks_admins" {
  display_name     = "aks-admins"
  security_enabled = true
}

resource "azuread_application" "aks_app" {
  display_name = "aks-app"
}

resource "azuread_service_principal" "aks_sp" {
  application_id = azuread_application.aks_app.application_id
}