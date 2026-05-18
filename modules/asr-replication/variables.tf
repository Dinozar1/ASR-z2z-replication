variable "replication_name" {
  type = string
}

variable "vault_rg_name" {
  type = string
}

variable "vault_name" {
  type = string
}

variable "fabric_name" {
  type = string
}

variable "source_vm_id" {
  type = string
}

variable "replication_policy_id" {
  type = string
}

variable "source_protection_container_name" {
  type = string
}

variable "target_resource_group_id" {
  type = string
}

variable "target_recovery_fabric_id" {
  type = string
}

variable "target_protection_container_id" {
  type = string
}

variable "target_network_id" {
  type = string
}

variable "target_subnet_name" {
  type = string
}

variable "target_zone" {
  type    = string
  default = "2"
}

variable "source_nic_id" {
  type = string
}

variable "cache_storage_account_id" {
  type = string
}

variable "os_disk_id" {
  type = string
}

variable "data_disk_ids" {
  type    = list(string)
  default = []
}

variable "target_disk_type" {
  type    = string
  default = "StandardSSD_LRS"
}

variable "target_replica_disk_type" {
  type    = string
  default = "StandardSSD_LRS"
}

variable "recovery_to_same_network" {
  type        = bool
  description = "Will asr recover to the same vnet after failover?"
}



variable "target_static_ip" {
  type    = string
  default = null

  # validation {
  #   condition = !(
  #     var.recovery_to_same_network && var.target_static_ip != null
  #   )
  #   error_message = "ASR can not recover to the same network with the same IP address."
  # }
}