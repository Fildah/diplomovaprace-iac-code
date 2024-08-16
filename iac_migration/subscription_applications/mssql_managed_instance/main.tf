# MSSQL managed instance

# Resource group pro MSSQL managed instance
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}

# Subnet pro MSSQL managed instance
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.vnet_rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.subnet_address_prefixes

  delegation {
    name = "sqlmanagedinstancedelegation"

    service_delegation {
      name    = "Microsoft.Sql/managedInstances"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
    }
  }
}

# Route table
resource "azurerm_route_table" "route_table" {
  name                          = var.route_table_name
  location                      = azurerm_resource_group.rg.location
  resource_group_name           = azurerm_resource_group.rg.name
  bgp_route_propagation_enabled = false
  depends_on = [
    azurerm_subnet.subnet,
  ]
}

# Asociace subentu a route table
resource "azurerm_subnet_route_table_association" "subnet_route_asoc" {
  subnet_id      = azurerm_subnet.subnet.id
  route_table_id = azurerm_route_table.route_table.id
}

# MSSQL managed instance
resource "azurerm_mssql_managed_instance" "sqlmi" {
  name                         = var.sqlmi_name
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  administrator_login          = var.sqlmi_admin_login
  administrator_login_password = var.sqlmi_admin_pass
  license_type                 = "BasePrice"
  subnet_id                    = azurerm_subnet.subnet.id
  sku_name                     = var.sqlmi_sku
  vcores                       = var.sqlmi_vcores
  storage_size_in_gb           = var.sqlmi_storage

  depends_on = [
    azurerm_subnet_route_table_association.subnet_route_asoc,
  ]
}

# MSSQL managed databaze
resource "azurerm_mssql_managed_database" "sqlmi_db" {
  managed_instance_id = azurerm_mssql_managed_instance.sqlmi.id
  name                = var.sqlmi_db_name

  lifecycle {
    prevent_destroy = true
  }
}