data "azurerm_monitor_diagnostic_categories" "main" {
  count = var.resources_count > 0 ? 1 : 0

  resource_id = var.resource_ids[0]
}

locals {
  log_categories = (
    var.log_categories != null ?
    toset(var.log_categories) :
    var.resources_count > 0 ? data.azurerm_monitor_diagnostic_categories.main[0].logs : null
  )
  metric_categories = (
    var.metric_categories != null ?
    toset(var.metric_categories) :
    var.resources_count > 0 ? data.azurerm_monitor_diagnostic_categories.main[0].metrics : null
  )

  logs = {
    for category in local.log_categories : category => {
      enabled        = true
      retention_days = var.retention_days
    }
  }

  metrics = {
    for metric in local.metric_categories : metric => {
      enabled        = true
      retention_days = var.retention_days
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "main" {
  count = var.resources_count

  name               = var.name
  target_resource_id = var.resource_ids[count.index]

  storage_account_id             = var.storage_account_id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  eventhub_authorization_rule_id = var.eventhub_authorization_rule_id

  dynamic "log" {
    for_each = local.logs

    content {
      category = log.key
      enabled  = log.value.enabled

      retention_policy {
        enabled = log.value.retention_days != null ? true : false
        days    = log.value.retention_days
      }
    }
  }

  dynamic "metric" {
    for_each = local.metrics

    content {
      category = metric.key
      enabled  = metric.value.enabled

      retention_policy {
        enabled = metric.value.retention_days != null ? true : false
        days    = metric.value.retention_days
      }
    }
  }
}
