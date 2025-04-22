# modules/resource_group/variables.tf
variable "name" {
  description = "Name of the resource group"
  type        = string
  default     = "aks-rg"
}

variable "location" {
  description = "Azure location"
  type        = string
  default     = "East US"
}