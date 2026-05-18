variable "location" {
  type = string
}

variable "rg_source_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "vm_size" {
  type    = string
  default = "Standard_F2"
}

variable "admin_username" {
  type    = string
  default = "adminuser"
}

variable "source_zone" {
  type    = string
  default = "1"
}

variable "os_disk_caching" {
  type    = string
  default = "ReadWrite"
}

variable "os_disk_storage_account_type" {
  type    = string
  default = "StandardSSD_LRS"
}

variable "image_publisher" {
  type    = string
  default = "Canonical"
}

variable "image_offer" {
  type    = string
  default = "0001-com-ubuntu-server-focal"
}

variable "image_sku" {
  type    = string
  default = "20_04-lts"
}

variable "image_version" {
  type    = string
  default = "latest"
}

variable "data_disk_storage_account_type" {
  type    = string
  default = "StandardSSD_LRS"
}

variable "data_disk_size_gb" {
  type    = number
  default = 1
}

variable "data_disk_lun" {
  type    = number
  default = 10
}

variable "data_disk_caching" {
  type    = string
  default = "ReadWrite"
}

variable "network_interface_name" {
  type = string
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