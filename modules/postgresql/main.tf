


# Now declare the PostgreSQL flexible server and use depends_on correctly
resource "azurerm_postgresql_flexible_server" "dev" {
  name                          = "postgresql-server-dev1"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = "12"
  delegated_subnet_id           = var.subnet_id
  private_dns_zone_id           = var.private_dns_zone_id
  public_network_access_enabled = false
  administrator_login           = var.postgresql_admin_user
  administrator_password        = var.postgresql_admin_password
  zone                          = var.zone

  storage_mb   = var.storage_mb
  storage_tier = var.storage_tier

  sku_name   = var.sku_name


}


