variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure location."
  type        = string
}

variable "aks_subnet_id" {
  description = "The subnet ID for the AKS cluster."
  type        = string
}


