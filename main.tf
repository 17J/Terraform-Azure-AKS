module "resource_group" {
  source   = "../../modules/resource_group"
  name     = var.resource_group_name
  location = var.location
}

module "vnet" {
  source              = "../../modules/vnet"
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = module.resource_group.name
}

module "aad" {
  source = "../../modules/aad"
}

module "aks" {
  source                 = "../../modules/aks"
  name                   = var.aks_name
  location               = var.location
  resource_group_name    = module.resource_group.name
  dns_prefix             = var.dns_prefix
  node_count             = var.node_count
  vm_size                = var.vm_size
  subnet_id              = module.vnet.subnet_id
  admin_group_object_id  = module.aad.admin_group_object_id
  tags                   = var.tags
}
