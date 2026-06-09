# Bootstrap — provisions the remote state backend
# Run this ONCE before the first terraform init on the main infra.
# Uses local state intentionally — this is the one resource that cannot store its own state remotely.

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
  features {}
}

module "tfstate_backend" {
  source = "../modules/tfstate-backend"

  resource_group_name  = var.resource_group_name
  location             = var.location
  storage_account_name = var.storage_account_name
  container_name       = var.container_name
  tags                 = var.tags
}
