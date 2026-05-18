variable "location" {
  type = string
}

variable "rg_source_name" {
  type = string
}

variable "rg_recovery_name" {
  type = string
}

variable "primary_vnet_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "primary_subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "recovery_vnet_cidr" {
  type    = string
  default = "10.1.0.0/16"
}

variable "recovery_subnet_cidr" {
  type    = string
  default = "10.1.1.0/24"
}

variable "testfailover_vnet_cidr" {
  type    = string
  default = "10.2.0.0/16"
}

variable "testfailover_subnet_cidr" {
  type    = string
  default = "10.2.1.0/24"
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