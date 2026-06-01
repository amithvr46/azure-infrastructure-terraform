# Root Outputs - key values after deployment

output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "vnet_name" {
  value = module.vnet.vnet_name
}

output "aks_cluster_name" {
  value = module.aks.cluster_name
}

output "key_vault_name" {
  value = module.keyvault.key_vault_name
}

output "key_vault_uri" {
  value = module.keyvault.key_vault_uri
}

output "acr_login_server" {
  value = module.acr.acr_login_server
}