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

variable "tags" {
  type = map(string)
}