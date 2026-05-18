resource "azurerm_recovery_services_vault" "vault" {
  name                = var.vault_name
  location            = var.location
  resource_group_name = var.rg_source_name
  sku                 = "Standard"
  storage_mode_type   = "LocallyRedundant"
}

resource "azurerm_site_recovery_fabric" "fabric" {
  name                = var.fabric_name
  resource_group_name = var.rg_source_name
  recovery_vault_name = azurerm_recovery_services_vault.vault.name
  location            = var.location
}

resource "azurerm_site_recovery_protection_container" "pc_primary" {
  name                 = var.primary_container_name
  resource_group_name  = var.rg_source_name
  recovery_vault_name  = azurerm_recovery_services_vault.vault.name
  recovery_fabric_name = azurerm_site_recovery_fabric.fabric.name
}

resource "azurerm_site_recovery_protection_container" "pc_secondary" {
  name                 = var.secondary_container_name
  resource_group_name  = var.rg_source_name
  recovery_vault_name  = azurerm_recovery_services_vault.vault.name
  recovery_fabric_name = azurerm_site_recovery_fabric.fabric.name
}

resource "azurerm_site_recovery_replication_policy" "policy" {
  name                                                 = var.replication_policy_name
  resource_group_name                                  = var.rg_source_name
  recovery_vault_name                                  = azurerm_recovery_services_vault.vault.name
  recovery_point_retention_in_minutes                  = var.recovery_point_retention_minutes
  application_consistent_snapshot_frequency_in_minutes = var.app_consistent_snapshot_minutes
}

resource "azurerm_site_recovery_protection_container_mapping" "container_mapping" {
  name                                      = var.container_mapping_name
  resource_group_name                       = var.rg_source_name
  recovery_vault_name                       = azurerm_recovery_services_vault.vault.name
  recovery_fabric_name                      = azurerm_site_recovery_fabric.fabric.name
  recovery_source_protection_container_name = azurerm_site_recovery_protection_container.pc_primary.name
  recovery_target_protection_container_id   = azurerm_site_recovery_protection_container.pc_secondary.id
  recovery_replication_policy_id            = azurerm_site_recovery_replication_policy.policy.id
}

resource "azurerm_storage_account" "cache" {
  name                     = var.cache_storage_account_name
  resource_group_name      = var.rg_source_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}