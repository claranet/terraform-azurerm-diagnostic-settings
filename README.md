# Diagnostic Settings

Create diagnostic settings for Azure resources.

## Example Usage

```hcl
module "diagnostic_settings" {
  source = "innovationnorway/diagnostic-settings/azurerm"

  resources_count = 1
  resource_ids    = [azurerm_key_vault.example.id]

  retention_days = 30

  storage_account_id = azurerm_storage_account.main.id
}
```

## Arguments
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| eventhub\_authorization\_rule\_id | The ID of the event hub authorization rule to send diagnostic logs to. | string | `"null"` | no |
| log\_analytics\_workspace\_id | The ID of the Log Analytics workspace to send diagnostic logs to. | string | `"null"` | no |
| log\_categories | List of log categories. | object | `"null"` | no |
| metric\_categories | List of metric categories. | object | `"null"` | no |
| name | The name of the diagnostic setting. | string | `"default"` | no |
| resource\_ids | The IDs of the resources list. The resources must be the same type. | list(string) | n/a | yes |
| resources\_count | The number of resources to configure. Must be the (non computed) size of the `resource_ids` list due to Terraform limitation. | number | n/a | yes |
| retention\_days | The number of days to keep diagnostic logs. | number | `"null"` | no |
| storage\_account\_id | The ID of the storage account to send diagnostic logs to. | string | `"null"` | no |
