terraform {
  required_version = ">= 1.4.0"
}

locals {
  subscription_id = "00000000-0000-0000-0000-000000000000"
  resource_id     = "/subscriptions/${local.subscription_id}/resourceGroups/${var.name}"
}

# Эмуляция azurerm_resource_group: смена location приводит к пересозданию ресурса (-/+),
# как и в реальном Azure.
resource "terraform_data" "resource_group" {
  input = {
    name     = var.name
    location = var.location
    id       = local.resource_id
  }

  triggers_replace = [
    var.name,
    var.location,
  ]
}
