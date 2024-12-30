variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure location for the resources."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the delegated subnet for the PostgreSQL Flexible Server."
  type        = string
}

variable "private_dns_zone_id" {
  description = "The ID of the private DNS zone for PostgreSQL Flexible Server."
  type        = string
  default     = null
}

variable "postgresql_admin_user" {
  description = "The admin username for the PostgreSQL server."
  type        = string
}

variable "postgresql_admin_password" {
  description = "The admin password for the PostgreSQL server."
  type        = string
  sensitive   = true
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


variable "postgresql_db_name" {
  description = "The name of the PostgreSQL database to create."
  type        = string
}

variable "virtual_network_id" {
  description = "The ID of the virtual network."
  type        = string
}
