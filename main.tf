provider "azurerm" {
  features {}
}

# Create Resource Group
resource "azurerm_resource_group" "dev" {
  name     = "rg-dev"
  location = "East US"
}

# Call Network Module
module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.dev.name
}

# Call PostgreSQL Module
module "postgresql" {
  source              = "./modules/postgresql"
  resource_group_name = azurerm_resource_group.dev.name
  location            = azurerm_resource_group.dev.location
}

# Call AKS Module
module "aks" {
  source              = "./modules/aks"
  resource_group_name = azurerm_resource_group.dev.name
  location            = azurerm_resource_group.dev.location
}

# Call Kubernetes Module for GHCR Deployment
module "kubernetes" {
  source              = "./modules/kubernetes"
  resource_group_name = azurerm_resource_group.dev.name
  aks_cluster_name    = module.aks.dev_cluster_name
  ghcr_pat            = var.ghcr_pat
  github_username     = var.github_username
  github_email        = var.github_email
}
