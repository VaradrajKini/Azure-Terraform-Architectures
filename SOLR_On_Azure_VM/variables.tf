variables "client_id" {
    description = "Client ID"
    type = string
}

variable "client_secret" {
  description = "Client Secret"
  type = string
}

variable "tenant_id" {
  description = "Tenant ID"
  type = string
}

variable "subscription_id" {
  description = "Subscription where the resource will be created"
  type = string
}

variable "environment" {
  type = string
}

# Define prefix that will be applied to all the Azure Resources
variable "prefix" {
  type = string
  default = "MC_SOLR_${var.environment}_"
}

variable "location" {
  type = string
  default = "EAST US 2"
}

variable "tags" {
    type = map(string)
    default = {
      "Environment" = "${var.environment}"
      "Application" = "SOLR"
      "Owner" = "Varadraj Kini"
      "Department" = "Finance"
    }
}

variable "resourcegroupname" {
  type = string
  default = "mcrg"
}

# Define Variables for Vnet

variable "vnet_address_range" {
  description = "IP address range for Virtual Network"
  type = string
  default = "10.0.0.0/16"
}

variable "Subnet_address_range" {
  description = "IP Address Range for Subnet"
  type = string
  default = "10.0.1.0/24"
}

# Public IP and NIC Allocation method

variable "alloction_method" {
  type = list(string)
  default = [ "static", "Dynamic" ]
}

variable "virtual_machine_size" {
  description = "Size of the virtual machine"
  type = string
  default = "Standard_B1s"
}

variable "computer_name" {
  description = "Computer Name"
  type = string
  default = "Win10SOLR"
}

variable "admin_password" {
  description = "password for windows server login"
  type = string
  default = "P@ssword1"
}

variable "os_disk_caching" {
  default = "ReadWrite"
}

variable "os_disk_storage_account_type" {
  default = "standardSSD_LRS"
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