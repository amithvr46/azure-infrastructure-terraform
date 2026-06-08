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

variable "image_retention_days" {
  description = "Days to retain untagged images before auto-deletion"
  type        = number
  default     = 30
}

variable "tags" {
  type = map(string)
}