variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "vnet_name" {
  description = "VNet name"
  type        = string
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
}

variable "address_space" {
  description = "VNet address space"
  type        = string
}

variable "subnet_prefix" {
  description = "Subnet address prefix"
  type        = string
}