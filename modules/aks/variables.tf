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

#variable "kubernetes_version" {
#  type    = string
#  default = "1.31"
#}

variable "node_count" {
  type    = number
  default = 2
}

variable "node_size" {
  type    = string
  default = "Standard_D2s_v3"
}

variable "aks_subnet_id" {
  description = "Subnet ID where AKS nodes will be deployed"
  type        = string
}

variable "tags" {
  type = map(string)
}