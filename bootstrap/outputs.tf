output "backend_resource_group" {
  value = module.tfstate_backend.resource_group_name
}

output "backend_storage_account" {
  value = module.tfstate_backend.storage_account_name
}

output "backend_container" {
  value = module.tfstate_backend.container_name
}
