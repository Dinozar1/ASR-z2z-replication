output "vault_name" {
  value = azurerm_recovery_services_vault.vault.name
}

output "fabric_name" {
  value = azurerm_site_recovery_fabric.fabric.name
}

output "fabric_id" {
  value = azurerm_site_recovery_fabric.fabric.id
}

output "pc_primary_name" {
  value = azurerm_site_recovery_protection_container.pc_primary.name
}

output "pc_secondary_id" {
  value = azurerm_site_recovery_protection_container.pc_secondary.id
}

output "replication_policy_id" {
  value = azurerm_site_recovery_replication_policy.policy.id
}

output "cache_storage_account_id" {
  value = azurerm_storage_account.cache.id
}