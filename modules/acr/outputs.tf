output "acr_id" {
  value = azurerm_container_registry.main.id
}

output "acr_name" {
  value = azurerm_container_registry.main.name
}

output "acr_login_server" {
  description = "The URL to use for docker login"
  value       = azurerm_container_registry.main.login_server
}