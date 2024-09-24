output "id" {
  description = "ID of the Diagnostic Settings."
  value       = one(azurerm_monitor_diagnostic_setting.main[*].id)
}

output "resource" {
  description = "Resource outputtf."
  value       = azurerm_monitor_diagnostic_setting.main[*]
}
