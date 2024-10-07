resource "azurerm_lb" "lb" {
  location            = module.azure_region.location
  name                = "lb"
  resource_group_name = module.rg.resource_group_name
}

module "diagnostic_settings" {
  source  = "claranet/diagnostic-settings/azurerm"
  version = "x.x.x"

  resource_id = azurerm_lb.lb.id

  logs_destinations_ids = [
    module.logs.logs_storage_account_id,
    module.logs.log_analytics_workspace_id,
  ]

  log_analytics_destination_type = "Dedicated"
}
