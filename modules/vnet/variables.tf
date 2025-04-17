variable "vnet_name" {}
variable "subnet_name" {}
variable "address_space" {}
variable "subnet_prefix" {}
variable "location" {}
variable "resource_group_name" {}
variable "tags" {
  type = map(string)
  default = {}
}