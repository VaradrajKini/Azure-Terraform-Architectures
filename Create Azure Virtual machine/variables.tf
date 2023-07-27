# List of variable required for this project

variable "client_id" {
  description = "Client ID for authentication"
  type = string
}

variable "client_secret" {
  description = "Client secret for authentication"
}

variable "tenant_id" {
  description = "Tenant ID"
}

variable "subscription_id" {
  description = "Azure subscription ID"
}

# Environments

variable "environment" {
  type = list(string)
  default = [ "PROD","STAGE","TEST","DEV" ]
}

# Prefix added to all Azure resources

variable "prefix" {
  description = "Prefix appended to all azure resources names"
  type = string
  default = "VK_VM_${var.environment}"
}

# Tags

variable "tags" {
  type = map(string)
  default = {
    "Application" = "app_name"
    "Application Owner" = "Owner Name"
    "Department" = "Finance"
    "Environment" = "${var.environment}"
  }
}

# Location

variable "location" {
  type = string
  default = "East US"
}

# Vnet and Subnet information

variable "vnet_address_range" {
  type = string
  default = "10.0.0.0/16"
}

variable "subnet_address_range" {
  type = string
  default = "10.0.1.0/24"
}

# Public IP and NIC Allocation method

variable "allocation method" {
  type = list(string)
  default = [ "Static", "Dynamic" ]
}

# Variables for Virtaul machine

variable "virtual_machine_size" {
  description = "Size of the VM"
  type = string
  default = "Standard_B1s"
}

variable "computer_name" {
  description = "Name of the Virtual Machine"
  type = string
  default = "vkwin${var.environment}"
}

variable "admin_username" {
  type = string
  default = "winadmin"
}

variable "admin_password" {
  description = "Password to access virtual machine"
  type = string
  default = "P@ssword1"
}

variable "os_disk_caching" {
  default = "ReadWrite"
}

variable "os_disk_storage_account_type" {
  default = "StandardSSD_LRS"
}

variable "os_disk_size_gb" {
  default = 128
}

variable "publisher" {
  default = "MicrosoftWindowsServer"
}

variable "offer" {
  default = "WindowsServer"
}

variable "sku" {
  default = "2019-Datacenter"
}

variable "vm_image_version" {
  default = "latest"
}