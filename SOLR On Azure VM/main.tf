provider "azurerm" {
      client_ID = var.client_id
      Client_Secret = var.client_secretecret
      tenant_id = var.tenant_id
      subscription_id = var.subscription_id
      features {}
}

# create a resource group
resource "azurerm_resource_group" "rg" {
    name = "${var.prefix}-${var.resourcegroupname}"
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

# create a subnet inside a vnet

resource "azurerm_subnet" "subnet" {
  name = "${prefix}-subnet"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = var.Subnet_address_range
}

# Crate a network security group

resource "azurerm_network_security_group" "nsg" {
  name = "${var.prefix}-nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location = var.location
  tags = var.tags

  security_rule = {
    name = "Allow_RDP"
    priority = 1000
    direction = "Inbound"
    access = "Allow"
    protocol = "TCP"
    source_port_range = "*"
    destination_port_range = 3389
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }
}

# Associate NSG to subnet

resource "azurerm_subnet_nat_gateway_association" "subnet-nsg" {
  subnet_id = azurerm_subnet.subnet.id
  nat_gateway_id = azurerm_network_security_group.nsg.id
}

# Public IP to access VM

resource "azurerm_public_ip" "pip" {
  name = "${var.prefix}-windows-vm-public-ip"
  resource_group_name = azurerm_resource_group.rg.name
  location = var.location
  allocation_method = var.allocation_method[0]
  tags = var.tags
}

# create a network interface card for Virtual machine

resource "azurerm_network_interface" "nic" {
  name = "${var.prefix}-nic"
  resource_group_name = azurerm_resource_group.rg.name
  location = var.location
  tags = var.tags
  ip_configuration {
    name = "${var.prefix}-nic-ipconfg"
    subnet_id = azurerm_subnet.subnet.id
    public_ip_address_id = azurerm_public_ip.pip.id
    private_ip_address_allocation = var.allocation_method[1]
  }
}

# create a virtual machine

resource "azurerm_virtual_machine" "vm" {
    name = "${var.prefix}-vm"
    resource_group_name = azurerm_resource_group.rg.name
    location = var.location
    tags = var.tags
    network_interface_ids = azurerm_network_interface.nic.ID
    size = var.virtual_machine_size
    computer_name = var.computer_name
    admin_username = var.admin_username
    admin_password = var.admin_password

    os_disk {
        name = "${var.prefix}-winvm-os-disk"
        caching = var.os_disk_caching
        storage_account_type = var.storage_account_type
        disk_size_gb = var.os_disk_size_gb
    }

    source_image_reference {
        publisher = var.publisher
        offer = var.offer
        sku = var.sku
        version = var.vm_image_version
    }
}

resource "null_resource" "copy_file" {
  connection {
    type = "winrm"
    host = azurerm_virtual_machine.vm.public_ip_address
    user = var.admin_username
    password = var.admin.password
  }

  provisioner "file" {
    source = "https://archive.apache.org/dist/lucene/solr/8.8.2/solr-8.8.2.zip"
    destination = "c:/WindowsServices/Temp"
  }
}