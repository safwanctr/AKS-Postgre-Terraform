output "dev_cluster_name" {
  value = module.aks.dev_cluster_name
}

output "dev_kube_config_raw" {
  value = module.aks.dev_kube_config_raw
  sensitive = true
}

output "dev_postgresql_host" {
  value = module.postgresql.dev_fqdn
}

output "dev_postgresql_username" {
  value = module.postgresql.dev_admin_user
}

output "dev_postgresql_password" {
  value = module.postgresql.dev_admin_password
  sensitive= true
}

output "dev_postgresql_database_name" {
  value = module.postgresql.dev_db_name
}

output "postgresql_fqdn" {
  description = "The FQDN of the PostgreSQL flexible server."
  value       = module.postgresql.dev_fqdn
}
