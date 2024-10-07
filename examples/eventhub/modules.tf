
module "lb" {
  source  = "claranet/lb/azurerm"
  version = "x.x.x"

  client_name    = var.client_name
  environment    = var.environment
  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  stack          = var.stack

  resource_group_name = module.rg.resource_group_name

  allocate_public_ip = true
  enable_nat         = true
}

module "eventhub" {
  source  = "claranet/eventhub/azurerm"
  version = "x.x.x"

  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack

  resource_group_name = module.rg.resource_group_name

  create_dedicated_cluster = false

  namespace_parameters = {
    sku      = "Standard"
    capacity = 2
  }

  hubs_parameters = {
    logs = {
      custom_name     = "main-logs-hub"
      partition_count = 2
    }
  }

  logs_destinations_ids = []
}

module "diagnostic_settings" {
  source  = "claranet/diagnostic-settings/azurerm"
  version = "x.x.x"

  resource_id = module.lb.lb_id

  logs_destinations_ids = [
    module.logs.logs_storage_account_id,
    module.logs.log_analytics_workspace_id,
    format("%s|%s", module.eventhub.namespace_send_authorization_rule.id, module.eventhub.eventhubs["logs"].name),
  ]

  log_analytics_destination_type = "Dedicated"
}
