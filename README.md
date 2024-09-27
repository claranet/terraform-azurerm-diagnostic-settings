# Azure Diagnostic Settings
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-blue.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![OpenTofu Registry](https://img.shields.io/badge/opentofu-registry-yellow.svg)](https://search.opentofu.org/module/claranet/diagnostic-settings/azurerm/)

This module is based on work from [Innovation Norway](https://github.com/InnovationNorway/).

This Terraform enables the Diagnostic Settings on a given Azure resource.

## Note for EventHub usage in destination

If you want to specify an Azure EventHub to send logs and metrics to in `logs_destinations_ids`,
you need to provide a formated string with both the EventHub Namespace authorization send ID
and the EventHub name (name of the queue to use in the Namespace) separated by the `|` character.

Please refer to the [example](#usage) below for a detailed implementation.

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | AzureRM version |
| -------------- | ----------------- | --------------- |
| >= 7.x.x       | 1.3.x             | >= 3.0          |
| >= 6.x.x       | 1.x               | >= 3.0          |
| >= 5.x.x       | 0.15.x            | >= 2.0          |
| >= 4.x.x       | 0.13.x / 0.14.x   | >= 2.0          |
| >= 3.x.x       | 0.12.x            | >= 2.0          |
| >= 2.x.x       | 0.12.x            | < 2.0           |
| <  2.x.x       | 0.11.x            | < 2.0           |

## Contributing

If you want to contribute to this repository, feel free to use our [pre-commit](https://pre-commit.com/) git hook configuration
which will help you automatically update and format some files for you by enforcing our Terraform code module best-practices.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

```hcl
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

module "logs" {
  source  = "claranet/run/azurerm//modules/logs"
  version = "x.x.x"

  client_name         = var.client_name
  environment         = var.environment
  stack               = var.stack
  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.resource_group_name
}

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
```

## Providers

| Name | Version |
|------|---------|
| azurecaf | ~> 1.2, >= 1.2.22 |
| azurerm | ~> 3.39 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_diagnostic_setting.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurecaf_name.diag](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |
| [azurerm_monitor_diagnostic_categories.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| custom\_name | Name of the diagnostic settings, generated if empty. | `string` | `""` | no |
| excluded\_log\_categories | List of log categories to exclude. | `list(string)` | `[]` | no |
| log\_analytics\_destination\_type | When set to 'Dedicated' logs sent to a Log Analytics workspace will go into resource specific tables, instead of the legacy AzureDiagnostics table. | `string` | `"AzureDiagnostics"` | no |
| log\_categories | List of log categories. Defaults to all available. | `list(string)` | `null` | no |
| logs\_destinations\_ids | List of destination resources IDs for logs diagnostic destination.<br>Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.<br>If you want to use Azure EventHub as destination, you must provide a formatted string with both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the <code>&#124;</code> character. | `list(string)` | n/a | yes |
| metric\_categories | List of metric categories. Defaults to all available. | `list(string)` | `null` | no |
| name\_prefix | Optional prefix for the generated name | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name | `string` | `""` | no |
| resource\_id | The ID of the resource on which activate the diagnostic settings. | `string` | n/a | yes |
| use\_caf\_naming | Use the Azure CAF naming provider to generate default resource name. `custom_name` override this if set. Legacy default name is used if this is set to `false`. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| diagnostic\_settings\_id | ID of the Diagnostic Settings. |
<!-- END_TF_DOCS -->
## Related documentation

Azure Diagnostic settings documentation: [docs.microsoft.com/en-us/azure/azure-monitor/essentials/diagnostic-settings](https://docs.microsoft.com/en-us/azure/azure-monitor/essentials/diagnostic-settings)
