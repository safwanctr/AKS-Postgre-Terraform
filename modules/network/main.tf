resource "azurerm_virtual_network" "dev" {
  name                = "vnet-dev"
  address_space       = ["172.32.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "aks" {
  name                 = "aks-subnet-dev"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.dev.name
  address_prefixes     = ["172.32.1.0/24"]
}

resource "azurerm_subnet" "postgresql" {
  name                 = "postgresql-subnet-dev"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.dev.name
  address_prefixes     = ["172.32.2.0/24"]
    delegation {
    name = "postgresql-fs-delegation"
    service_delegation {
      name    = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_network_security_group" "aks_nsg" {
  name                = "aks-nsg-dev"
  location            = var.location
  resource_group_name = var.resource_group_name

  # Inbound rule to allow SSH for management (for debugging)
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

  # Inbound rule for LoadBalancer frontend service (port 80 or any other as needed)
  security_rule {
    name                       = "Allow-Frontend-HTTP"
    priority                   = 1010
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Inbound rule for backend communication (port 8000 or as required)
  security_rule {
    name                       = "Allow-Backend-HTTP"
    priority                   = 1020
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Allow internal communication between AKS nodes/pods (for Kubernetes communication)
  security_rule {
    name                       = "Allow-AKS-Internal-Communication"
    priority                   = 1030
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "172.32.1.0/24"  # AKS Subnet CIDR
    destination_address_prefix = "172.32.1.0/24"  # AKS Subnet CIDR
  }

  # Allow communication between AKS and PostgreSQL subnet (port 5432 for Postgres)
  security_rule {
    name                       = "Allow-PostgreSQL-Access"
    priority                   = 1040
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefix      = "172.32.1.0/24"  # AKS Subnet CIDR
    destination_address_prefix = "172.32.2.0/24"  # PostgreSQL Subnet CIDR
  }
}

resource "azurerm_network_security_group" "postgresql_nsg" {
  name                = "postgresql-nsg-dev"
  location            = var.location
  resource_group_name = var.resource_group_name

  # Inbound rule to allow PostgreSQL access (for backend to connect)
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

  # Allow internal communication from AKS subnet to PostgreSQL subnet
  security_rule {
    name                       = "Allow-AKS-to-PostgreSQL"
    priority                   = 1010
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefix      = "172.32.1.0/24"  # AKS Subnet CIDR
    destination_address_prefix = "172.32.2.0/24"  # PostgreSQL Subnet CIDR
  }
}

# Optional: Attach the NSG to AKS subnet
resource "azurerm_subnet_network_security_group_association" "aks_subnet_association" {
  subnet_id                 = azurerm_subnet.aks.id
  network_security_group_id = azurerm_network_security_group.aks_nsg.id
}

# Optional: Attach the NSG to PostgreSQL subnet
resource "azurerm_subnet_network_security_group_association" "postgresql_subnet_association" {
  subnet_id                 = azurerm_subnet.postgresql.id
  network_security_group_id = azurerm_network_security_group.postgresql_nsg.id
}


resource "azurerm_private_dns_zone" "dev" {
  name                = "dev.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dev" {
  name                  = "postgres-dns-link"
  private_dns_zone_name = azurerm_private_dns_zone.dev.name
  virtual_network_id    = azurerm_virtual_network.dev.id
  resource_group_name   = var.resource_group_name
  registration_enabled  = false
}