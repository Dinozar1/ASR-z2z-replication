variable "region" {
  description = "Azure region"
  type        = string
  default     = "polandcentral"
}

variable "subscription_id" {
  type = string
}

variable "rg-name-primary" {
  type    = string
  default = "ASR-failover-primary"
}

variable "rg-name-secondary" {
  type    = string
  default = "ASR-failover-secondary"
}

variable "ASR-cache-storage-account-name" {
  type        = string
  default     = "cachez2zlog4321"
  description = "Name must be globally unique"
}


variable "ASR-vault-name" {
  type    = string
  default = "z2z-recovery-vault"
}

variable "NIC_name" {
  type    = string
  default = "nic-primary-az1-"
}


variable "linux_vm_name" {
  type    = string
  default = "primary-linux-vm-az1"
}

variable "vm_os_disk_name" {
  type    = string
  default = "primary-vm-os-disk"
}

variable "vm_managed_disk_name" {
  type    = string
  default = "primary-data-disk-az1"
}


variable "vnet_primary_name" {
  type    = string
  default = "vnet-primary"
}

variable "vnet_recovery_name" {
  type    = string
  default = "vnet-recovery"
}

variable "vnet_test_failover_name" {
  type    = string
  default = "vnet_test_failover"
}

variable "subnet_primary_name" {
  type    = string
  default = "subnet_primary"
}

variable "subnet_recovery_name" {
  type    = string
  default = "subnet_recovery"
}

variable "subnet_test_failover_name" {
  type    = string
  default = "subnet_test_failover"
}

variable "primary_container_name" {
  type    = string
  default = "pc-primary"
}
variable "secondary_container_name" {
  type    = string
  default = "pc-secondary"
}