# Remote state backend — Azure Blob Storage
# Storage account provisioned by bootstrap/ module.
# The state key (dev/prod) is passed at runtime via -backend-config in the pipeline.

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "amithvr46tfstate"
    container_name       = "tfstate"
  }
}
