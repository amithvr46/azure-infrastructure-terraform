# Key Vault Module - Secrets Management
# Creates: Key Vault with access policies and RBAC
# Mirrors real-world secrets management at Wells Fargo / Fidelity

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "main" {
  name                = "kv-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  # Security settings
  enabled_for_disk_encryption     = true
  enabled_for_deployment          = true
  enabled_for_template_deployment = true
  purge_protection_enabled        = true
  soft_delete_retention_days      = 7

  # Network rules - only allow from VNet
  network_acls {
    default_action             = "Allow"
    bypass                     = "AzureServices"
    virtual_network_subnet_ids = var.allowed_subnet_ids
  }

  tags = var.tags
}

# Access policy for current user / service principal
resource "azurerm_key_vault_access_policy" "admin" {
  key_vault_id = azurerm_key_vault.main.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get", "List", "Create", "Delete",
    "Update", "Recover", "Purge"
  ]

  secret_permissions = [
    "Get", "List", "Set", "Delete",
    "Recover", "Purge"
  ]

  certificate_permissions = [
    "Get", "List", "Create", "Delete",
    "Update", "Recover", "Purge"
  ]
}

# Access policy for AKS managed identity
resource "azurerm_key_vault_access_policy" "aks" {
  key_vault_id = azurerm_key_vault.main.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.aks_identity_id

  secret_permissions = [
    "Get", "List"
  ]
}

# Store a sample secret - demonstrates how pipelines pull secrets
resource "azurerm_key_vault_secret" "sample" {
  name         = "sample-secret"
  value        = "this-is-a-secret-value"
  key_vault_id = azurerm_key_vault.main.id

  tags = var.tags

  depends_on = [azurerm_key_vault_access_policy.admin]
}