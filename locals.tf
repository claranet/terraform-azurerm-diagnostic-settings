locals {
  enabled = length(var.logs_destinations_ids) > 0

  log_categories = [
    for log in
    (
      var.log_categories != null ?
      var.log_categories :
      try(data.azurerm_monitor_diagnostic_categories.main[0].log_category_types, [])
    ) : log if !contains(var.excluded_log_categories, log)
  ]

  metric_categories = (
    var.metric_categories != null ?
    var.metric_categories :
    try(data.azurerm_monitor_diagnostic_categories.main[0].metrics, [])
  )

  metrics = {
    for metric in try(data.azurerm_monitor_diagnostic_categories.main[0].metrics, []) : metric => {
      enabled = true
    } if contains(local.metric_categories, metric)
  }

  storage_id       = coalescelist([for r in var.logs_destinations_ids : r if contains(split("/", lower(r)), "microsoft.storage")], [null])[0]
  log_analytics_id = coalescelist([for r in var.logs_destinations_ids : r if contains(split("/", lower(r)), "microsoft.operationalinsights")], [null])[0]

  eventhub_authorization_rule_id = coalescelist([for r in var.logs_destinations_ids : split("|", r)[0] if contains(split("/", lower(r)), "microsoft.eventhub")], [null])[0]
  eventhub_name                  = coalescelist([for r in var.logs_destinations_ids : try(split("|", r)[1], null) if contains(split("/", lower(r)), "microsoft.eventhub")], [null])[0]

  log_analytics_destination_type = local.log_analytics_id != null ? var.log_analytics_destination_type : null
}
