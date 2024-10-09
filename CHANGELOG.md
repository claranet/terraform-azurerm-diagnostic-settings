## 8.0.0 (2024-10-09)

### ⚠ BREAKING CHANGES

* **AZ-1088:** rework module

### Features

* **AZ-1088:** rework module 5a8547f

### Bug Fixes

* **AZ-1088:** fix Gitlab CI fceebdd
* **AZ-1088:** to revert when all modules in v8 eafb3bc

### Documentation

* **AZ-1088:** add missing parameter in example f506158
* **AZ-1088:** fix `logs_destinations_ids` variable description dcd0f95
* **AZ-1088:** fix parameters in example c7b64dc

### Miscellaneous Chores

* **AZ-1088:** apply suggestions 218f7e0
* **AZ-1088:** fix pre-commit config b265399
* **AZ-1088:** fix README and Examples cb0a716
* **AZ-1088:** fix wrong filename / fix example 53eb1b7
* **AZ-1088:** use new resource output description 323add2
* **deps:** update dependency opentofu to v1.8.3 73b3a2d
* **deps:** update dependency pre-commit to v4 1ea5ac1
* **deps:** update dependency pre-commit to v4.0.1 e639984
* **deps:** update dependency trivy to v0.56.0 ffda632
* **deps:** update dependency trivy to v0.56.1 e69ee10
* **deps:** update pre-commit hook pre-commit/pre-commit-hooks to v5 edb5855
* update examples structure 65bc7df

## 7.0.0 (2024-10-03)

### ⚠ BREAKING CHANGES

* **AZ-840:** AzureRM provider v3+ required

### Features

* **AZ-840:** prepare `v7.0` 382a348
* use Claranet "azurecaf" provider fb01ff4

### Documentation

* update README badge to use OpenTofu registry 6b7e973
* update README with `terraform-docs` v0.19.0 703f0b7

### Continuous Integration

* **AZ-1391:** enable semantic-release [skip ci] fef2c5f
* **AZ-1391:** update semantic-release config [skip ci] 8402395

### Miscellaneous Chores

* **deps:** add renovate.json 610db55
* **deps:** enable automerge on renovate b600c1b
* **deps:** update dependency opentofu to v1.7.0 4a5ca99
* **deps:** update dependency opentofu to v1.7.1 95c54de
* **deps:** update dependency opentofu to v1.7.2 864316a
* **deps:** update dependency opentofu to v1.7.3 daa4644
* **deps:** update dependency opentofu to v1.8.0 f508f52
* **deps:** update dependency opentofu to v1.8.1 e46abc4
* **deps:** update dependency pre-commit to v3.7.1 7f5ffce
* **deps:** update dependency pre-commit to v3.8.0 27f2518
* **deps:** update dependency terraform-docs to v0.18.0 5161843
* **deps:** update dependency tflint to v0.51.0 60b2700
* **deps:** update dependency tflint to v0.51.1 990ad19
* **deps:** update dependency tflint to v0.51.2 4f406ee
* **deps:** update dependency tflint to v0.52.0 9e30c6e
* **deps:** update dependency tflint to v0.53.0 f128d53
* **deps:** update dependency trivy to v0.50.2 ccbbd7e
* **deps:** update dependency trivy to v0.50.4 f8f2b56
* **deps:** update dependency trivy to v0.51.0 c7ae1a7
* **deps:** update dependency trivy to v0.51.1 87cf4b0
* **deps:** update dependency trivy to v0.51.2 07a6710
* **deps:** update dependency trivy to v0.51.4 7b04e80
* **deps:** update dependency trivy to v0.52.0 4a045c9
* **deps:** update dependency trivy to v0.52.1 75ab937
* **deps:** update dependency trivy to v0.52.2 4a7fa84
* **deps:** update dependency trivy to v0.53.0 c131ccf
* **deps:** update dependency trivy to v0.54.1 92fc01b
* **deps:** update dependency trivy to v0.55.0 3f8461b
* **deps:** update dependency trivy to v0.55.1 d6a65c6
* **deps:** update dependency trivy to v0.55.2 5c549c9
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.17.0 05de89b
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.18.0 fe36b72
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.0 e2dff38
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.1 0d35ccf
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.2 7d211d0
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.3 c0d24bb
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.93.0 9e6b61e
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.0 df63aea
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.1 74ff8dd
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.3 b72b3c9
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.95.0 1ea3a05
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.96.0 d352b23
* **deps:** update renovate.json 5789f6b
* **deps:** update tools ac6a9ed
* **deps:** update tools f3409bc
* **pre-commit:** update commitlint hook 77f13e9
* **release:** remove legacy `VERSION` file 61e5773

# v6.5.0 - 2023-09-01

Breaking
  * AZ-1153: Remove `retention_days` parameters, it must be handled at destination level now. (for reference: [Provider issue](https://github.com/hashicorp/terraform-provider-azurerm/issues/23051))

# v6.4.2 - 2023-09-01

Changed
  * AZ-1153: Ignore the `retention_days` variable as intermediate solution for quick propagation. See https://github.com/hashicorp/terraform-provider-azurerm/issues/23051

# v6.4.1 - 2023-04-28

Fixed
  * [GH-2](https://github.com/claranet/terraform-azurerm-diagnostic-settings/pull/2/files): Fix log categories

# v6.4.0 - 2023-04-28

Changed
  * [GH-2](https://github.com/claranet/terraform-azurerm-diagnostic-settings/pull/2/files): Replace log with `enabled_log` in `azurerm_monitor_diagnostic_setting` due to deprecation
  * [GH-2](https://github.com/claranet/terraform-azurerm-diagnostic-settings/pull/2/files): `logs_destinations_ids` is not nullable anymore

# v6.3.0 - 2023-02-07

Added
  * AZ-993: Allow to exclude some log categories

# v6.2.1 - 2023-01-03

Fixed
  * AZ-968: Fix README

# v6.2.0 - 2022-11-23

Changed
  * AZ-908: Use the new data source for CAF naming (instead of resource)

# v6.1.0 - 2022-10-21

Updated
  * AZ-839: Update and optimize module code

Added
  * AZ-846: Properly handle `EventHub` type in log destinations

# v6.0.0 - 2022-09-16

Breaking
  * AZ-839: Require Terraform 1.1+ and AzureRM provider `v3.21.1+`
  * AZ-839: Use the new `logs_category_*` attributes in Azure diagnostics data resource (https://github.com/hashicorp/terraform-provider-azurerm/pull/16367)

# v5.0.0 - 2022-01-12

Breaking
  * AZ-515: Option to use Azure CAF naming provider to name resources
  * AZ-515: Require Terraform 0.13+

# v4.0.3 - 2021-10-25

Changed
  * AZ-572: Revamp examples and improve CI

Fixed
  * AZ-589: Avoid plan drift when specifying categories

# v4.0.2 - 2021-08-24

Changed
  * AZ-532: Revamp README with latest `terraform-docs` tool
  * AZ-530: Cleanup module, fix linter errors

# v4.0.1 - 2020-12-03

Fixed
  * AZ-391: Fix the possibility for an id to be either upper or lower case

# v3.0.0/v4.0.0 - 2020-11-27

Breaking
  * AZ-160: Revamp module

Added
  * AZ-363: Add `log_analytics_destination_type` option (only for DataFactory so far)

Fixed
  * AZ-383: Fix empty logs destinations

## 1.0.0 (2019-05-10)

Added
  * initial release by Innovation Norway ([bfc0361](https://github.com/innovationnorway/terraform-azurerm-diagnostic-settings/commit/bfc0361))
