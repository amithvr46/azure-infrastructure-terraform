# ACR Module - Azure Container Registry
# Creates: Container Registry with AKS pull permissions
# AKS pulls images from here during deployments

resource "azurerm_container_registry" "main" {
  name                = "acr${var.project_name}${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false

  # Geo-replication disabled for dev (saves cost)
  # Enable for prod environments

  tags = var.tags
}

# Give AKS permission to pull images from ACR
# This is the real-world pattern used at Wells Fargo / Fidelity
resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id                     = var.aks_identity_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.main.id
  skip_service_principal_aad_check = true
}