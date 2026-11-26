output "id" {
  description = "Mock Resource Group ID"
  value       = terraform_data.resource_group.output.id
}

output "location" {
  description = "Mock Resource Group location"
  value       = terraform_data.resource_group.output.location
}

output "name" {
  description = "Mock Resource Group name"
  value       = terraform_data.resource_group.output.name
}
