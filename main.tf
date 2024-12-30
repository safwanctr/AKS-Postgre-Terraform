terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.71.0" # Use the latest version compatible with your Terraform version
    }
  }
}


provider "azurerm" {
  features {}
 subscription_id = "cf849225-7954-446b-83d5-acd506068fdb" 
}

# Create Resource Group
resource "azurerm_resource_group" "dev" {
  name     = "rg-dev"
  location = "East US 2"
}

# Call Network Module
module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.dev.name
  location = azurerm_resource_group.dev.location 
}



# Call AKS Module
module "aks" {
  source              = "./modules/aks"
  resource_group_name = azurerm_resource_group.dev.name
  location            = azurerm_resource_group.dev.location
  aks_subnet_id       = module.network.subnet_aks_id
  depends_on          = [module.network]
}

# Call PostgreSQL Module
module "postgresql" {
  source                  = "./modules/postgresql"
  resource_group_name     = var.resource_group_name
  location                = var.location
  postgresql_admin_user   = var.postgresql_admin_user
  postgresql_admin_password = var.postgresql_admin_password
  subnet_id               = module.network.subnet_postgre_id  # Ensure subnet_id is passed here
  private_dns_zone_id     = module.network.private_dns_zone_id
  virtual_network_id      = module.network.vnet_id  # Pass the virtual network ID
  zone                    = var.zone
  storage_mb              = var.storage_mb
  storage_tier            = var.storage_tier
  sku_name                = var.sku_name
  postgresql_db_name      = var.postgresql_db_name
  depends_on              = [module.network]
}

# Call Kubernetes Module for GHCR Deployment
module "kubernetes" {
  source              = "./modules/kubernetes"
  resource_group_name = azurerm_resource_group.dev.name
  aks_cluster_name    = module.aks.dev_cluster_name
  ghcr_pat            = var.ghcr_pat
  github_username     = var.github_username
  github_email        = var.github_email
  repo_name           = var.repo_name
  backend_repo_name   = var.backend_repo_name
  frontend_repo_name  = var.frontend_repo_name
  depends_on          = [module.aks, module.postgresql]
}

#resource "azurerm_subnet" "aks_subnet" {
#  name                 = "aks-subnet"
#  resource_group_name  = azurerm_resource_group.dev.name
#  virtual_network_name = azurerm_virtual_network.vnet.name
#  address_prefixes     = ["10.0.2.0/24"]  # Adjust the address space based on your network design
#}


#resource "azurerm_virtual_network" "vnet" {
#  name                = "aks-vnet"
#  resource_group_name = azurerm_resource_group.dev.name
#  location            = azurerm_resource_group.dev.location
#  address_space       = ["10.0.0.0/16"]  # Adjust address space as per your needs
#}


provider "kubernetes" {
  host                   = module.aks.kube_config.host
  client_certificate     = base64decode(module.aks.kube_config.client_certificate)
  client_key             = base64decode(module.aks.kube_config.client_key)
  cluster_ca_certificate = base64decode(module.aks.kube_config.cluster_ca_certificate)
}
