output "nic_id" {
  value = azurerm_network_interface.nic_primary_az1.id
}

output "vm_id" {
  value = azurerm_linux_virtual_machine.primary_linux_vm.id
}

output "vm_name" {
  value = azurerm_linux_virtual_machine.primary_linux_vm.name
}

output "vm_size" {
  value = azurerm_linux_virtual_machine.primary_linux_vm.size
}

output "os_disk_id" {
  value = azurerm_linux_virtual_machine.primary_linux_vm.os_managed_disk_id
}

output "data_disk_id" {
  value = azurerm_managed_disk.primary_data_disk.id
}

output "data_disk_ids" {
  value = [azurerm_managed_disk.primary_data_disk.id]
}

output "ssh_public_key_openssh" {
  value = tls_private_key.primary_ssh_key.public_key_openssh
}

output "ssh_private_key_pem" {
  value     = tls_private_key.primary_ssh_key.private_key_pem
  sensitive = true
}

output "primary_nic_ip" {
  value = azurerm_network_interface.nic_primary_az1.private_ip_address
}