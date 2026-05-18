resource "azurerm_network_interface" "nic_primary_az1" {
  name                = var.network_interface_name
  location            = var.location
  resource_group_name = var.rg_source_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "tls_private_key" "primary_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_linux_virtual_machine" "primary_linux_vm" {
  name                = var.linux_vm_name
  resource_group_name = var.rg_source_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  zone                = var.source_zone

  network_interface_ids = [
    azurerm_network_interface.nic_primary_az1.id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.primary_ssh_key.public_key_openssh
  }

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
    name                 = var.vm_os_disk_name
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

}

resource "azurerm_managed_disk" "primary_data_disk" {
  name                 = var.vm_managed_disk_name
  location             = var.location
  resource_group_name  = var.rg_source_name
  storage_account_type = var.data_disk_storage_account_type
  create_option        = "Empty"
  disk_size_gb         = var.data_disk_size_gb
  zone                 = var.source_zone

  lifecycle {
    ignore_changes = [
      create_option,
      source_resource_id,
      tags
    ]
  }

}

resource "azurerm_virtual_machine_data_disk_attachment" "pr_data_disk_attachment" {
  managed_disk_id    = azurerm_managed_disk.primary_data_disk.id
  virtual_machine_id = azurerm_linux_virtual_machine.primary_linux_vm.id
  lun                = var.data_disk_lun
  caching            = var.data_disk_caching
}