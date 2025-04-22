variable "name" {
  type        = string
  default     = "myAKSCluster"
}

variable "location" {
  type    = string
  default = "East US"
}

variable "resource_group_name" {
  type = string
}

variable "dns_prefix" {
  type    = string
  default = "aksdns"
}

variable "node_count" {
  type    = number
  default = 2
}

variable "vm_size" {
  type    = string
  default = "Standard_DS2_v2"
}

variable "subnet_id" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {
    environment = "dev"
  }
}

variable "admin_group_object_id" {
  type = string
}
