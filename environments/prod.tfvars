resource_group_name = "rg-azure-infra-prod"
environment         = "prod"
location            = "East US"
project_name        = "azinfra"

# Production-grade cluster — HA node count, larger VMs
aks_node_count     = 3
aks_node_size      = "Standard_D4s_v3"
kubernetes_version = "1.34"

vnet_address_space = ["10.1.0.0/16"]
subnet_prefixes = {
  aks  = "10.1.1.0/24"
  app  = "10.1.2.0/24"
  data = "10.1.3.0/24"
}

acr_sku                      = "Premium"
acr_retention_policy_enabled = true
acr_image_retention_days     = 30

tags = {
  project     = "azure-infra"
  owner       = "amith-busireddy"
  team        = "platform-engineering"
  cost-center = "engineering"
}
