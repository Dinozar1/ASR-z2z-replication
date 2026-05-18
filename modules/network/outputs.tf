output "primary_vnet_id" {
  value = azurerm_virtual_network.vnet_primary.id
}

output "primary_subnet_id" {
  value = azurerm_subnet.snet_primary.id
}

output "primary_subnet_name" {
  value = azurerm_subnet.snet_primary.name
}

output "recovery_vnet_id" {
  value = azurerm_virtual_network.vnet_recovery.id
}

output "recovery_subnet_id" {
  value = azurerm_subnet.snet_recovery.id
}

output "recovery_subnet_name" {
  value = azurerm_subnet.snet_recovery.name
}

output "testfailover_vnet_id" {
  value = azurerm_virtual_network.vnet_testfailover.id
}

output "testfailover_subnet_id" {
  value = azurerm_subnet.snet_testfailover.id
}

output "testfailover_subnet_name" {
  value = azurerm_subnet.snet_testfailover.name
}

output "primary_subnet_cidr" {
  value = var.primary_subnet_cidr
}