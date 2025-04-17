module "vnet" {
  source              = "./modules/vnet"
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = var.vnet_name
  subnet_name         = var.subnet_name
  address_space       = var.address_space
  subnet_prefix       = var.subnet_prefix
}

module "aad" {
  source    = "./modules/aad"
  tenant_id = var.tenant_id
}

module "aks" {
  source                      = "./modules/aks"
  resource_group_name         = var.resource_group_name
  location                    = var.location
  cluster_name                = var.cluster_name
  kubernetes_version          = var.kubernetes_version
  subnet_id                   = module.vnet.subnet_id
  aad_admin_group_object_id   = module.aad.admin_group_object_id
  client_app_id               = module.aad.client_app_id
  server_app_id               = module.aad.server_app_id
  server_app_secret           = module.aad.server_app_secret
  tenant_id                   = var.tenant_id
}
