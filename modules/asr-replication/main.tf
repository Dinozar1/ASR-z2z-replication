resource "azurerm_site_recovery_replicated_vm" "vm_replication" {
  name                                      = var.replication_name
  resource_group_name                       = var.vault_rg_name
  recovery_vault_name                       = var.vault_name
  source_recovery_fabric_name               = var.fabric_name
  source_vm_id                              = var.source_vm_id
  recovery_replication_policy_id            = var.replication_policy_id
  source_recovery_protection_container_name = var.source_protection_container_name

  target_resource_group_id                = var.target_resource_group_id
  target_recovery_fabric_id               = var.target_recovery_fabric_id
  target_recovery_protection_container_id = var.target_protection_container_id
  target_network_id                       = var.target_network_id
  target_zone                             = var.target_zone

  network_interface {
    source_network_interface_id = var.source_nic_id
    target_subnet_name          = var.target_subnet_name

    target_static_ip = var.target_static_ip
  }

  managed_disk {
    disk_id                    = var.os_disk_id
    staging_storage_account_id = var.cache_storage_account_id
    target_resource_group_id   = var.target_resource_group_id
    target_disk_type           = var.target_disk_type
    target_replica_disk_type   = var.target_replica_disk_type
  }

  dynamic "managed_disk" {
    for_each = var.data_disk_ids
    content {
      disk_id                    = managed_disk.value
      staging_storage_account_id = var.cache_storage_account_id
      target_resource_group_id   = var.target_resource_group_id
      target_disk_type           = var.target_disk_type
      target_replica_disk_type   = var.target_replica_disk_type
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}