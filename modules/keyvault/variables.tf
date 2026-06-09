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

variable "allowed_subnet_ids" {
  description = "List of subnet IDs allowed to access Key Vault"
  type        = list(string)
  default     = []
}

variable "aks_identity_id" {
  description = "AKS managed identity object ID for Key Vault access"
  type        = string
  default     = ""
}

variable "tags" {
  type = map(string)
}