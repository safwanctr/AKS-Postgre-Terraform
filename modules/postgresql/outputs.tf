output "postgresql_flexible_server_name" {
  description = "The name of the PostgreSQL Flexible Server."
  value       = azurerm_postgresql_flexible_server.dev.name
}



output "postgresql_flexible_server_admin_login" {
  description = "The administrator login for the PostgreSQL Flexible Server."
  value       = azurerm_postgresql_flexible_server.dev.administrator_login
}

output "dev_fqdn" {
  value = azurerm_postgresql_flexible_server.dev.fqdn
}

output "dev_admin_user" {
  value = var.postgresql_admin_user
}

output "dev_admin_password" {
  value = var.postgresql_admin_password
  sensitive= true
}

output "dev_db_name" {
  value = var.postgresql_db_name
}
