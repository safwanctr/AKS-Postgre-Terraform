variable "resource_group_name" {
  description = "Name of the resource group where Kubernetes resources are deployed."
  type        = string
}

variable "aks_cluster_name" {
  description = "Name of the AKS cluster."
  type        = string
}

variable "ghcr_pat" {
  description = "GitHub Container Registry Personal Access Token."
  type        = string
}

variable "github_username" {
  description = "GitHub username for container registry authentication."
  type        = string
}

variable "github_email" {
  description = "GitHub email for container registry authentication."
  type        = string
}


variable "repo_name" {
  description = "The name of the GitHub repository to pull the container image from."
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