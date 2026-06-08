# Testing AI PR reviewer - infrastructure variables

# Root Variables

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-azure-infra-dev"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name used in resource naming"
  type        = string
  default     = "azinfra"
}

variable "tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default = {
    environment = "dev"
    project     = "azure-infra"
    owner       = "amith-busireddy"
    managed-by  = "terraform"
    github      = "github.com/amithbusireddy/azure-infrastructure-terraform"
  }
}

# VNet
variable "vnet_address_space" {
  description = "Address space for VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_prefixes" {
  description = "Subnet address prefixes"
  type        = map(string)
  default = {
    aks  = "10.0.1.0/24"
    app  = "10.0.2.0/24"
    data = "10.0.3.0/24"
  }
}

# AKS
variable "aks_node_count" {
  description = "Number of AKS nodes"
  type        = number
  default     = 2
}

variable "aks_node_size" {
  description = "VM size for AKS nodes"
  type        = string
  default     = "Standard_D2s_v3"
}

# ACR
variable "acr_sku" {
  description = "ACR SKU — Standard for dev, Premium for prod"
  type        = string
  default     = "Standard"
}

variable "acr_retention_policy_enabled" {
  description = "Enable retention policy — requires Premium SKU"
  type        = bool
  default     = false
}

variable "acr_image_retention_days" {
  description = "Days to retain untagged images (Premium only)"
  type        = number
  default     = 30
}

variable "kubernetes_version" {
  description = "Kubernetes version — pin to a specific LTS version, upgrade intentionally"
  type        = string
  default     = "1.34"
}