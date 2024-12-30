variable "github_username" {
  description = "GitHub Username"
  type        = string
}

variable "ghcr_pat" {
  description = "GitHub Container Registry Personal Access Token"
  type        = string
}

variable "github_email" {
  description = "GitHub Email"
  type        = string
}

variable "location" {
  description = "Azure Region"
  type        = string
  default     = "East US 2"
}

variable "postgresql_admin_user" {
  description = "PostgreSQL Admin Username"
  type        = string
}

variable "postgresql_admin_password" {
  description = "PostgreSQL Admin Password"
  type        = string
}

variable "postgresql_db_name" {
  description = "PostgreSQL Database Name"
  type        = string
  default     = "dev_db"
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "repo_name" {
  description = "The GitHub repository name."
  type        = string
}

variable "frontend_repo_name" {
  description = "The name of the GitHub repository for the frontend"
  type        = string
}

variable "backend_repo_name" {
  description = "The name of the GitHub repository for the backend"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet for the PostgreSQL Flexible Server."
  type        = string
}

variable "private_dns_zone_id" {
  description = "The ID of the private DNS zone for PostgreSQL Flexible Server."
  type        = string
  default     = null
}


variable "zone" {
  description = "The availability zone for the PostgreSQL Flexible Server. Use null for automatic placement."
  type        = string
  default     = null
}


variable "storage_mb" {
  description = "The storage size in MB for the PostgreSQL Flexible Server."
  type        = number
  default     = 32768
}

variable "storage_tier" {
  description = "The storage tier for the PostgreSQL Flexible Server (e.g., 'P1', 'P2', 'P3', 'P30')."
  type        = string
  default     = "P30"
}

variable "sku_name" {
  description = "The SKU name for the PostgreSQL Flexible Server."
  type        = string
  default     = "GP_Standard_D4s_v3"
}

#variable "virtual_network_id" {
#  description = "The ID of the virtual network."
#  type        = string
#}
