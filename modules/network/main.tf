resource "azurerm_virtual_network" "vnet_primary" {
  name                = var.vnet_primary_name
  location            = var.location
  resource_group_name = var.rg_source_name
  address_space       = [var.primary_vnet_cidr]
}

resource "azurerm_subnet" "snet_primary" {
  name                 = var.subnet_primary_name
  resource_group_name  = var.rg_source_name
  virtual_network_name = azurerm_virtual_network.vnet_primary.name
  address_prefixes     = [var.primary_subnet_cidr]
}

resource "azurerm_virtual_network" "vnet_recovery" {
  name                = var.vnet_recovery_name
  location            = var.location
  resource_group_name = var.rg_recovery_name
  address_space       = [var.recovery_vnet_cidr]
}

resource "azurerm_subnet" "snet_recovery" {
  name                 = var.subnet_recovery_name
  resource_group_name  = var.rg_recovery_name
  virtual_network_name = azurerm_virtual_network.vnet_recovery.name
  address_prefixes     = [var.recovery_subnet_cidr]
}

resource "azurerm_virtual_network" "vnet_testfailover" {
  name                = var.vnet_test_failover_name
  location            = var.location
  resource_group_name = var.rg_recovery_name
  address_space       = [var.testfailover_vnet_cidr]
}

resource "azurerm_subnet" "snet_testfailover" {
  name                 = var.subnet_test_failover_name
  resource_group_name  = var.rg_recovery_name
  virtual_network_name = azurerm_virtual_network.vnet_testfailover.name
  address_prefixes     = [var.testfailover_subnet_cidr]
}