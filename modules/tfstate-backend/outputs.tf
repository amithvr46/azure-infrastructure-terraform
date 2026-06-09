output "resource_group_name" {
  description = "Resource group containing the state storage account"
  value       = azurerm_resource_group.tfstate.name
}

output "storage_account_name" {
  description = "Storage account name — use in terraform init -backend-config"
  value       = azurerm_storage_account.tfstate.name
}

output "container_name" {
  description = "Blob container name — use in terraform init -backend-config"
  value       = azurerm_storage_container.tfstate.name
}

output "storage_account_id" {
  description = "Resource ID of the storage account"
  value       = azurerm_storage_account.tfstate.id
}
