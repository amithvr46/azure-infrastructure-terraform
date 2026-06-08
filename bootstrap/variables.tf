variable "resource_group_name" {
  description = "Resource group for Terraform remote state storage"
  type        = string
  default     = "rg-tfstate"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "storage_account_name" {
  description = "Storage account name — must be globally unique, 3-24 lowercase alphanumeric"
  type        = string
  default     = "amithvr46tfstate"
}

variable "container_name" {
  description = "Blob container name for state files"
  type        = string
  default     = "tfstate"
}

variable "tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default = {
    environment  = "shared"
    project      = "azure-infra"
    owner        = "amith-busireddy"
    managed-by   = "terraform"
    purpose      = "terraform-remote-state"
  }
}
