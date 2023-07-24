terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.66.0"
    }
  }
}

provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "WBAssig"
    storage_account_name = "wbsaaa"
    container_name       = "tfstate"
    key                  = "vnet-terraform.tfstate"
  }
}

data "azurerm_resource_group" "rg" {
  name = "${var.name}-rg"
}

resource "azurerm_virtual_network" "vn" {
  name                = "${var.name}-vnet"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = [var.network_address_space]
}

resource "azurerm_subnet" "aks-subnet" {
  name                 = var.aks_subnet_address_name
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefixes     = [var.aks_subnet_address_prefix]
}

resource "azurerm_subnet" "example" {
  name                 = var.subnet_address_name
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefixes     = [var.subnet_address_prefix]
}