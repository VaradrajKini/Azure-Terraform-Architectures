provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "My_resource_group" {
    name = var.ResourceGroupName
    location = var.location
    tags = var.tags
}