variable "resource_group_name" {
  type = string
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "storage_account_name" {
  type = string
}

variable "containers" {
  type    = list(string)
  default = ["bronze", "silver", "gold"]
}
