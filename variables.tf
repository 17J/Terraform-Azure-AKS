variable "resource_group_name" {
  default = "aks-rg"
}

variable "location" {
  default = "East US"
}

variable "vnet_name" {
  default = "aks-vnet"
}

variable "vnet_address_space" {
  default = ["10.0.0.0/16"]
}

variable "aks_name" {
  default = "aks-cluster"
}

variable "dns_prefix" {
  default = "aksdns"
}

variable "node_count" {
  default = 2
}

variable "vm_size" {
  default = "Standard_DS2_v2"
}

variable "tags" {
  default = {
    environment = "dev"
  }
}
