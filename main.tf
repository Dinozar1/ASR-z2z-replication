resource "azurerm_resource_group" "rg" {
  name     = var.rg-name-primary
  location = var.region
}

resource "azurerm_resource_group" "rg_recovery" {
  name     = var.rg-name-secondary
  location = var.region
}



module "network" {
  source = "./modules/network"

  location         = var.region
  rg_source_name   = azurerm_resource_group.rg.name
  rg_recovery_name = azurerm_resource_group.rg_recovery.name

  vnet_primary_name       = "${var.vnet_primary_name}-${var.region}"
  vnet_recovery_name      = "${var.vnet_recovery_name}-${var.region}"
  vnet_test_failover_name = "${var.vnet_test_failover_name}-${var.region}"

  subnet_primary_name       = "${var.subnet_primary_name}-${var.region}"
  subnet_recovery_name      = "${var.subnet_recovery_name}-${var.region}"
  subnet_test_failover_name = "${var.subnet_test_failover_name}-${var.region}"
}



module "compute" {
  source = "./modules/compute"

  location               = var.region
  rg_source_name         = azurerm_resource_group.rg.name
  subnet_id              = module.network.primary_subnet_id
  network_interface_name = "${var.NIC_name}-${var.region}"
  linux_vm_name          = "${var.linux_vm_name}-${var.region}"
  vm_os_disk_name        = "${var.vm_os_disk_name}-${var.region}"
  vm_managed_disk_name   = "${var.vm_managed_disk_name}-${var.region}"

}



module "asr_core" {
  source = "./modules/asr-core"

  location                 = var.region
  rg_source_name           = azurerm_resource_group.rg.name
  vault_name               = "${var.ASR-vault-name}-${var.region}"
  primary_container_name   = "${var.primary_container_name}-${var.region}"
  secondary_container_name = "${var.secondary_container_name}-${var.region}"

  //Must be global unique
  cache_storage_account_name = var.ASR-cache-storage-account-name
}



module "asr_replication" {
  source = "./modules/asr-replication"

  vault_rg_name    = azurerm_resource_group.rg.name
  vault_name       = module.asr_core.vault_name
  fabric_name      = module.asr_core.fabric_name
  replication_name = "${var.linux_vm_name}-${var.region}"

  source_vm_id  = module.compute.vm_id
  source_nic_id = module.compute.nic_id

  os_disk_id    = module.compute.os_disk_id
  data_disk_ids = module.compute.data_disk_ids

  replication_policy_id            = module.asr_core.replication_policy_id
  source_protection_container_name = module.asr_core.pc_primary_name

  target_resource_group_id       = azurerm_resource_group.rg_recovery.id
  target_recovery_fabric_id      = module.asr_core.fabric_id
  target_protection_container_id = module.asr_core.pc_secondary_id


  target_network_id  = module.network.primary_vnet_id
  target_subnet_name = module.network.primary_subnet_name


  target_zone = "2"

  cache_storage_account_id = module.asr_core.cache_storage_account_id

}

module "automation" {
  source   = "./modules/automation"
  location = var.region

  recovery_rg_name = azurerm_resource_group.rg_recovery.name

  recovery_rg_id = azurerm_resource_group.rg_recovery.id

  primary_rg_id   = azurerm_resource_group.rg.id
  primary_rg_name = azurerm_resource_group.rg.name
  target_nic_name = "${var.NIC_name}-${var.region}"

  dummy_ip_address  = cidrhost(module.network.primary_subnet_cidr, -5)
  recovery_nic_name = "${var.NIC_name}-${var.region}"



}
