output "resouce-names" {
  description = "Print the names of the resources"
  value = {
    "Resource-Group-Name" = azurerm_resource_group.rg.name
    "Vnet-Name" = azurerm_virtual_network.vnet.name
    "Subnet-Name" = azurerm_subnet.subnet.name
    "NSG-Name" = azurerm_network_security_group.nsg.name
    "NIC-Name" = azurerm_network_interface.nic.name
  }
}

output "public_ip_address" {
  value = azurerm_public_ip.pip.ip_address
}

output "win_vm_login" {
  value = {
    "Virtual-Machine-Name" = azurerm_virtual_machine.vm.name 
    "User Name" = azurerm_virtual_machine.vm.admin_username
    "Password" = azurerm_virtual_machine.vm.admin_password
}
}