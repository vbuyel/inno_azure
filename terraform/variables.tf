variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
}

variable "admin_password" {
  type        = string
  sensitive   = true
  description = "VM admin password (min 12 chars, upper/lower/digit/symbol)"
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "resource_group_name" {
  type    = string
  default = "rg-practice-1"
}
