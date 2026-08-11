terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-tf-labs"
  location = "East US 2"
  tags = {
    test = "manual"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name = "vnet-lab"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space    = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "snet0" {
  name = "Web"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name = azurerm_resource_group.rg.name
  address_prefixes = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "snet1" {
  name = "App"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name = azurerm_resource_group.rg.name
  address_prefixes = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "snet2" {
  name = "DB"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name = azurerm_resource_group.rg.name
  address_prefixes = ["10.0.3.0/24"]
}