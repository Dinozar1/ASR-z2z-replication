variable "aaname" {
  type    = string
  default = "aa-asr-recovery"
}

variable "location" {
  type = string
}

variable "recovery_rg_name" {
  type = string
}

variable "recovery_rg_id" {
  type = string
}

variable "role_name" {
  type    = string
  default = "Network Contributor"
}

variable "runbook_name" {
  type    = string
  default = "Remove-PrimaryNIC-runbook"
}

variable "primary_rg_name" {
  type = string
}

variable "primary_rg_id" {
  type = string
}


variable "target_nic_name" {
  type = string
}

variable "dummy_ip_address" {
  type = string
}


variable "recovery_nic_name" {
  type = string
}

variable "target_ip_address" {
  type = string
}