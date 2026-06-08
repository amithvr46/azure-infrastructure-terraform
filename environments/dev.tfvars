resource_group_name = "rg-azure-infra-dev"
environment         = "dev"
location            = "East US"
project_name        = "azinfra"

# Smaller cluster — lower cost for dev
aks_node_count     = 1
aks_node_size      = "Standard_D2s_v3"
kubernetes_version = "1.34"

vnet_address_space = ["10.0.0.0/16"]
subnet_prefixes = {
  aks  = "10.0.1.0/24"
  app  = "10.0.2.0/24"
  data = "10.0.3.0/24"
}

tags = {
  environment = "dev"
  project     = "azure-infra"
  owner       = "amith-busireddy"
  managed-by  = "terraform"
  github      = "github.com/amithvr46/azure-infrastructure-terraform"
}
