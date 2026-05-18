

resource "azurerm_automation_account" "asr_automation" {
  name                = var.aaname
  location            = var.location
  resource_group_name = var.recovery_rg_name
  sku_name            = "Basic"
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "auto_network_contributor" {
  scope                = var.primary_rg_id
  role_definition_name = var.role_name

  principal_id = azurerm_automation_account.asr_automation.identity[0].principal_id


}

resource "azurerm_role_assignment" "auto_network_contributor_recovery" {
  scope                = var.recovery_rg_id
  role_definition_name = var.role_name

  principal_id = azurerm_automation_account.asr_automation.identity[0].principal_id


}

resource "azurerm_automation_runbook" "release_ip_runbook" {
  name                = var.runbook_name
  location            = var.location
  resource_group_name = var.recovery_rg_name

  automation_account_name = azurerm_automation_account.asr_automation.name

  log_verbose = true

  log_progress = true

  runbook_type = "PowerShell"

  content = <<-EOF

    Param(
    [object]$RecoveryPlanContext
)

try {
    Connect-AzAccount -Identity -ErrorAction Stop

        $nicName         = "${var.target_nic_name}"
        $recoveryNicName = "${var.recovery_nic_name}"
        $rgName          = "${var.primary_rg_name}"
        $recoveryRgName  = "${var.recovery_rg_name}"
        $dummyIp         = "${var.dummy_ip_address}"

        $nic1 = Get-AzNetworkInterface -Name $nicName -ResourceGroupName $rgName -ErrorAction Stop
        $nic2 = Get-AzNetworkInterface -Name $recoveryNicName -ResourceGroupName $recoveryRgName -ErrorAction Stop
        
        $ip1 = $nic1.IpConfigurations[0].PrivateIpAddress
        $ip2 = $nic2.IpConfigurations[0].PrivateIpAddress

        $subnetId = $nic1.IpConfigurations[0].Subnet.Id
        $parts    = $subnetId -split '/'
        $vnetRg   = $parts[4]
        $vnetName = $parts[8]

        $dummyCheck = Test-AzPrivateIPAddressAvailability `
            -VirtualNetworkName $vnetName `
            -ResourceGroupName  $vnetRg `
            -IPAddress          $dummyIp

        if (-not $dummyCheck.Available) {
            throw "IP $dummyIp is already allocated"
        }

        #dummy ip allocation
        $nic1.IpConfigurations[0].PrivateIpAllocationMethod = "Static"
        $nic1.IpConfigurations[0].PrivateIpAddress          = $dummyIp
        Set-AzNetworkInterface -NetworkInterface $nic1 -ErrorAction Stop

        
        #ip from stopped vm allocation to new vm
        $nic2.IpConfigurations[0].PrivateIpAllocationMethod = "Static"
        $nic2.IpConfigurations[0].PrivateIpAddress          = $ip1
        Set-AzNetworkInterface -NetworkInterface $nic2 -ErrorAction Stop

        #ip from started vm (got from dhcp) allocated to stoped vm
        $nic1.IpConfigurations[0].PrivateIpAllocationMethod = "Static"
        $nic1.IpConfigurations[0].PrivateIpAddress          = $ip2
        Set-AzNetworkInterface -NetworkInterface $nic1 -ErrorAction Stop
    }
    catch {
        Write-Error "Error occurred: $_"
        throw
    }

    EOF

}