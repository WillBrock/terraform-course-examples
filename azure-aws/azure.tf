provider "azurerm" {
	version  = "~> 2.13"
	features {}
}

resource "azurerm_resource_group" "rg" {
	name     = "tuts-rg"
	location = "westus"

	tags = {
		foo = "bar"
	}
}

resource "azurerm_virtual_network" "main" {
	name                = "tuts-network"
	address_space       = ["10.0.0.0/16"]
	location            = azurerm_resource_group.rg.location
	resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "web" {
	name                 = "tuts-subnet"
	resource_group_name  = azurerm_resource_group.rg.name
	virtual_network_name = azurerm_virtual_network.main.name
	address_prefixes     = ["10.0.1.0/24"]
}
