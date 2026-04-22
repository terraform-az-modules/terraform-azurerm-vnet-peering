# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [v2.0.0] - 2026-04-22
### :bug: Bug Fixes
- [`9353fac`](https://github.com/terraform-az-modules/terraform-azurerm-vnet-peering/commit/9353facbbbf732e1eb22b643b6aae706cd56ad97) - consolidate versions.tf, remove provider_meta, upgrade to azurerm >= 4.0 *(commit by [@anmolnagpal](https://github.com/anmolnagpal))*
- [`32b2565`](https://github.com/terraform-az-modules/terraform-azurerm-vnet-peering/commit/32b2565752ec59e8034d469d54d75b25a2806773) - align example versions.tf with root module (>= 4.0, >= 1.10.0) *(commit by [@anmolnagpal](https://github.com/anmolnagpal))*

### :wrench: Chores
- [`2e94db6`](https://github.com/terraform-az-modules/terraform-azurerm-vnet-peering/commit/2e94db6752a468e33b43ad4183bf956df8a65e83) - **deps**: bump hashicorp/setup-terraform from 3 to 4 *(commit by [@dependabot[bot]](https://github.com/apps/dependabot))*
- [`4e316a8`](https://github.com/terraform-az-modules/terraform-azurerm-vnet-peering/commit/4e316a851abf6751f7ada72235140a34dd0dea78) - **deps**: bump terraform-linters/setup-tflint from 4 to 6 *(commit by [@dependabot[bot]](https://github.com/apps/dependabot))*
- [`e7426fe`](https://github.com/terraform-az-modules/terraform-azurerm-vnet-peering/commit/e7426fe9ad469c455cbebeba2e2217e3ba331952) - **deps**: bump actions/checkout from 4 to 6 *(commit by [@dependabot[bot]](https://github.com/apps/dependabot))*
- [`d713f04`](https://github.com/terraform-az-modules/terraform-azurerm-vnet-peering/commit/d713f042a7c40d8d5130c405b9a999778712afe9) - add provider_meta for API usage tracking *(PR [#15](https://github.com/terraform-az-modules/terraform-azurerm-vnet-peering/pull/15) by [@clouddrove-ci](https://github.com/clouddrove-ci))*
- [`6233d1f`](https://github.com/terraform-az-modules/terraform-azurerm-vnet-peering/commit/6233d1fd2de1a502eae25e3714a453bc6862b0fc) - polish module with basic example, changelog, and version fixes *(PR [#16](https://github.com/terraform-az-modules/terraform-azurerm-vnet-peering/pull/16) by [@clouddrove-ci](https://github.com/clouddrove-ci))*
- [`7fc4ea5`](https://github.com/terraform-az-modules/terraform-azurerm-vnet-peering/commit/7fc4ea5b679af044b5e213a3996fd1945f1e2e01) - **deps**: bump actions/checkout from 3 to 6 *(commit by [@dependabot[bot]](https://github.com/apps/dependabot))*


## [1.0.1] - 2026-03-20

### Changes
- Add provider_meta for API usage tracking
- Add terraform tests and pre-commit CI workflow
- Add SECURITY.md, CONTRIBUTING.md, .releaserc.json
- Standardize pre-commit to antonbabenko v1.105.0
- Set provider: none in tf-checks for validate-only CI
- Bump required_version to >= 1.10.0
[v2.0.0]: https://github.com/terraform-az-modules/terraform-azurerm-vnet-peering/compare/v1.0.1...v2.0.0
