# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "test-rg" {
  name     = "test-rg"
  location = "West Europe"
  tags = {
    environment = "dev"
  }
}

resource "azurerm_virtual_network" "test-rg-vnet" {
  name                = "test-rg-vnet"
  location            = azurerm_resource_group.test-rg.location
  resource_group_name = azurerm_resource_group.test-rg.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "dev"
  }
}

resource "azurerm_subnet" "test-rg-subnet" {
  name                 = "test-rg-subnet"
  resource_group_name  = azurerm_resource_group.test-rg.name
  virtual_network_name = azurerm_virtual_network.test-rg-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "test-rg-nsg" {
  name                = "test-rg-nsg"
  location            = azurerm_resource_group.test-rg.location
  resource_group_name = azurerm_resource_group.test-rg.name

  tags = {
    environment = "dev"
  }
}

resource "azurerm_network_security_rule" "test-rg-nsg-rule1" {
  name                        = "rule1"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "188.122.202.31/32"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.test-rg.name
  network_security_group_name = azurerm_network_security_group.test-rg-nsg.name
}

resource "azurerm_subnet_network_security_group_association" "test-rg-nsg-ass" {
  subnet_id                 = azurerm_subnet.test-rg-subnet.id
  network_security_group_id = azurerm_network_security_group.test-rg-nsg.id
}

resource "azurerm_public_ip" "test-rg-publicip1" {
  name                = "test-rg-publicip1"
  resource_group_name = azurerm_resource_group.test-rg.name
  location            = azurerm_resource_group.test-rg.location
  allocation_method   = "Dynamic"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_network_interface" "test-rg-nic" {
  name                = "test-rg-nic"
  location            = azurerm_resource_group.test-rg.location
  resource_group_name = azurerm_resource_group.test-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.test-rg-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.test-rg-publicip1.id
  }

  tags = {
    environment = "dev"
  }
}