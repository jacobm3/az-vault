data "azurerm_resource_group" "main" {
  name = "${var.prefix}-rg"
}

data "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  resource_group_name = "${var.prefix}-rg"
}

data "azurerm_subnet" "internal" {
  name                 = "internal"
  virtual_network_name = data.azurerm_virtual_network.main.name
  resource_group_name  = data.azurerm_resource_group.main.name
}
