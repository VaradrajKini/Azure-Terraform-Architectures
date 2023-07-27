# Create a Windows Virtual machine

provider "azurerm" {
  version = ">=2.6"
  client_id = var.client_id
  client_secret = var.client_secret
  tenant_id = var.tenant_id
  subscription_id = var.subscription_id

  features {}
}

# Create a resource group

resource "azurerm_resource_group" "rg" {
  name = "${var.prefix}-rg"
  location = var.location
  tags = var.tags
}

# create a virtual network

resource "azurerm_virtual_network" "vnet" {
  name = "${var.prefix}-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location = var.location
  address_space = var.vnet_address_range
  tags = var.tags
}

# Create a subnet

resource "azurerm_subnet" "subnet" {
  name = "${var.prefix}-subnet"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = var.subnet_address_range   
}

#  create a network security group - NSG

resource "azurerm_network_security_group" "nsg" {
  name = "${var.prefix}-nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location = var.location
  tags = var.tags

  security_rule {
    name = "Allow_RDP"
    priority = 1000
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "3389"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }
}

# subnet nsg association

resource "azurerm_subnet_network_security_group_association" "subnet-nsg" {
    subnet_id = azurerm_subnet.subnet.id
    network_security_group_id = azurerm_network_security_group.nsg.id
}

# Create a public IP to associate with VM

resource "azurerm_public_ip" "pip" {
  name = "${var.prefix}-pip"
  resource_group_name = azurerm_resource_group.rg.name
  location = var.location
  tags = var.tags
  allocation_method = var.allocation[0]
}

# Create a network interface card for VM

resource "azurerm_network_interface" "nic" {
  name = "${var.prefix}-nic"
  resource_group_name = azurerm_resource_group.rg.name
  location = var.location
  tags = var.tags
  ip_configuration {
    name = "${var.prefix}-nic-ipconfig"
    subnet_id = azurerm_subnet.subnet.id
    public_ip_address_id = azurerm_public_ip.pip.id
    private_ip_address_allocation = var.allocation_method[1]
  }
}


# Create a windows 2019 server VM

resource "azurerm_virtual_machine" "vm" {
  name = "${var.prefix}-winvm"
  resource_group_name = azurerm_resource_group.rg.name
  location = var.location
  tags = var.tags
  network_interface_ids = [azurerm_network_interface.nic.id]
  size = var.virtual_machine_size
  computer_name = var.computer_name
  admin_username = var.admin_username
  admin_password = var.admin_password

  os_disk = {
    name = "${var.prefix}-winvm-os-disk"
    caching = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
    disk_size_gb = var.os_disk_size_gb
  }

  source_image_refrence {
    publisher = var.publisher
    offer = var.offer
    sku = var.sku
    version = var.vm_image_version
  }
}