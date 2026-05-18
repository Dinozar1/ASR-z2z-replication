variable "location" {
  type = string
}

variable "rg_source_name" {
  type = string
}

variable "vault_name" {
  type = string
}

variable "cache_storage_account_name" {
  type = string
}

variable "replication_policy_name" {
  type    = string
  default = "policy-24h-retention"
}

variable "recovery_point_retention_minutes" {
  type    = number
  default = 1440
}

variable "app_consistent_snapshot_minutes" {
  type    = number
  default = 240
}

variable "fabric_name" {
  type    = string
  default = "azure-fabric"
}

variable "primary_container_name" {
  type    = string
  default = "pc-primary"
}

variable "secondary_container_name" {
  type    = string
  default = "pc-secondary"
}

variable "container_mapping_name" {
  type    = string
  default = "container-mapping"
}
