# Computed tags — merge user-defined base tags with auto-generated values.
# Modules receive their own tag set so Azure cost reports can filter by tier/service.

locals {
  common_tags = merge(var.tags, {
    environment = var.environment
    managed-by  = "terraform"
    repository  = "github.com/amithvr46/azure-infrastructure-terraform"
  })

  vnet_tags = merge(local.common_tags, {
    tier    = "networking"
    service = "virtual-network"
  })

  aks_tags = merge(local.common_tags, {
    tier    = "compute"
    service = "kubernetes"
  })

  keyvault_tags = merge(local.common_tags, {
    tier    = "security"
    service = "key-vault"
  })

  acr_tags = merge(local.common_tags, {
    tier    = "registry"
    service = "container-registry"
  })
}
