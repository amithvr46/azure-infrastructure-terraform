# AKS Module - Kubernetes Cluster
# Creates: AKS Cluster with autoscaler, managed identity

resource "azurerm_kubernetes_cluster" "main" {
  name                = "aks-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.project_name}-${var.environment}"
#  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name                = "systempool"
    node_count          = var.node_count
    vm_size             = var.node_size
    vnet_subnet_id      = var.aks_subnet_id
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 5

    upgrade_settings {
      max_surge = "10%"
    }
  }

  # Managed Identity - no service principal needed
  identity {
    type = "SystemAssigned"
  }

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  network_profile {
    network_plugin     = "azure"
    network_policy     = "azure"
    load_balancer_sku  = "standard"
    service_cidr       = "10.1.0.0/16"
    dns_service_ip     = "10.1.0.10"
  }

  # Enable monitoring
  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id
  }

  tags = var.tags
}

# Log Analytics Workspace for AKS monitoring
resource "azurerm_log_analytics_workspace" "main" {
  name                = "law-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = var.tags
}