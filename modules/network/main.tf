resource "azurerm_virtual_network" "dev" {
  name                = "vnet-dev"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "aks" {
  name                 = "aks-subnet-dev"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.dev.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "postgresql" {
  name                 = "postgresql-subnet-dev"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.dev.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_security_group" "aks_nsg" {
  name                = "aks-nsg-dev"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "postgresql_nsg" {
  name                = "postgresql-nsg-dev"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-Postgres"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
