output "dev_cluster_name" {
  value = azurerm_kubernetes_cluster.dev.name
}

output "dev_kube_config_raw" {
  value = azurerm_kubernetes_cluster.dev.kube_config_raw
}

output "kube_config" {
  description = "Kubeconfig for the AKS cluster"
  value = {
    host                   = azurerm_kubernetes_cluster.dev.kube_config[0].host
    client_certificate     = azurerm_kubernetes_cluster.dev.kube_config[0].client_certificate
    client_key             = azurerm_kubernetes_cluster.dev.kube_config[0].client_key
    cluster_ca_certificate = azurerm_kubernetes_cluster.dev.kube_config[0].cluster_ca_certificate
  }
  sensitive = true
}
