variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "aks_identity_id" {
  description = "AKS managed identity to grant ACR pull permissions"
  type        = string
}

variable "sku" {
  description = "ACR SKU — Standard for dev, Premium for prod (retention policy requires Premium)"
  type        = string
  default     = "Standard"
}

variable "image_retention_days" {
  description = "Days to retain untagged images before auto-deletion (Premium SKU only)"
  type        = number
  default     = 30
}

variable "retention_policy_enabled" {
  description = "Enable retention policy — requires Premium SKU"
  type        = bool
  default     = false
}

variable "tags" {
  type = map(string)
}