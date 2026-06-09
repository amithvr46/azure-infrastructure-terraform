# Azure Infrastructure - Root Module
# Author: Amith Busireddy
# Wires together: VNet + AKS + Key Vault + ACR

terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

# Resource Group - everything lives inside this
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
  tags     = local.common_tags
}

# Module 1 - VNet (networking foundation)
module "vnet" {
  source = "./modules/vnet"

  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  vnet_address_space  = var.vnet_address_space
  subnet_prefixes     = var.subnet_prefixes
  tags                = local.vnet_tags
}

# Module 2 - AKS (Kubernetes cluster inside the VNet)
module "aks" {
  source = "./modules/aks"

  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  kubernetes_version = var.kubernetes_version
  node_count         = var.aks_node_count
  node_size          = var.aks_node_size
  aks_subnet_id      = module.vnet.aks_subnet_id
  tags               = local.aks_tags

  depends_on = [module.vnet]
}

# Module 3 - Key Vault (secrets management)
module "keyvault" {
  source = "./modules/keyvault"

  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  allowed_subnet_ids  = [module.vnet.aks_subnet_id]
  aks_identity_id     = module.aks.cluster_identity
  tags                = local.keyvault_tags

  depends_on = [module.aks]
}

# Module 4 - ACR (container registry)
module "acr" {
  source = "./modules/acr"

  project_name             = var.project_name
  environment              = var.environment
  location                 = var.location
  resource_group_name      = azurerm_resource_group.main.name
  aks_identity_id          = module.aks.cluster_identity
  sku                      = var.acr_sku
  retention_policy_enabled = var.acr_retention_policy_enabled
  image_retention_days     = var.acr_image_retention_days
  tags                     = local.acr_tags

  depends_on = [module.aks]
}