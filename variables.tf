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
  default     = "East US"
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
