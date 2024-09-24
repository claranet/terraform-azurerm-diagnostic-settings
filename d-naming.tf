data "azurecaf_name" "diag" {
  name          = "default"
  resource_type = "azurerm_monitor_diagnostic_setting"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([local.name_suffix])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}
