resource "azurerm_kubernetes_cluster" "dev" {
  name                = "dev-cluster"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "dev-cluster"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
    vnet_subnet_id = var.aks_subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "calico"
  }
}
