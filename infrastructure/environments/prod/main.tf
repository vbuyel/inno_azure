module "rg" {
  source   = "../../modules/resource-group"
  name     = "rg-inno-prod"
  location = var.location
}

module "storage" {
  source               = "../../modules/storage"
  resource_group_name  = module.rg.name
  location             = module.rg.location
  storage_account_name = var.storage_account_name
}

module "identity" {
  source              = "../../modules/identity"
  name                = "id-inno-prod"
  resource_group_name = module.rg.name
  location            = module.rg.location
}

module "monitoring" {
  source              = "../../modules/monitoring"
  name                = "log-inno-prod"
  resource_group_name = module.rg.name
  location            = module.rg.location
}
