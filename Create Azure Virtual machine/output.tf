# Display resource names

output "resource_names" {
  description = "Display information about resources created"
  value = {
    "Resource-Group-Name" = azurerm_resource_group.rg.name
    "Vnet-Name" = azurerm_virtual_network.vnet.name
    "Subnet-Name" = azurerm_subnet.subnet.name
    "NSG-Name" = azurerm_network_security_group.nsg.name
    "NIC-Name" = azurerm_network_interface.nic.name
  }
}

# Display public IP addres of VM to RDP

output "public_ip_address" {
  description = "Display Public IP address of Virtual Machine"
  value = azurerm_public_ip.pip.ip_address
}

# Display virtual machine details

output "virtual_machine_details" {
  description = "VM details and credentials to login"
  value = {
    "Virtual-Machine-name"= azurerm_virtual_machine.vm.name
    "Admin Username" = azurerm_virtual_machine.vm.admin_username
    "Admin Password" = azurerm_virtual_machine.vm.admin_password
  }
}