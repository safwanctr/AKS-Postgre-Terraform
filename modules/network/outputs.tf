output "subnet_aks_id" {
  value = azurerm_subnet.aks.id
}

output "subnet_postgre_id" {
  value = azurerm_subnet.postgresql.id
}

output "vnet_id" {
  value = azurerm_virtual_network.dev.id
}

output "private_dns_zone_id" {
  description = "The ID of the private DNS zone."
  value       = azurerm_private_dns_zone.dev.id
}