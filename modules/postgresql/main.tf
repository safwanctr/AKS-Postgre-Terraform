resource "azurerm_postgresql_server" "dev" {
  name                         = "postgresql-server-dev"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  version                      = "11"
  administrator_login          = var.postgresql_admin_user
  administrator_login_password = var.postgresql_admin_password
  sku_name                     = "B_Gen5_1"
  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup         = "Disabled"
}

resource "azurerm_postgresql_database" "dev" {
  name                = var.postgresql_db_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.dev.name
}
