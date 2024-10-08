module "azure_region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location    = module.azure_region.location
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

# Log Analytics
resource "azurerm_log_analytics_workspace" "log_workspace" {
  name                = "law-example"
  location            = module.azure_region.location
  resource_group_name = module.rg.resource_group_name

  sku               = "PerGB2018"
  retention_in_days = 30
  daily_quota_gb    = -1

}
