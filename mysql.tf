resource "azurerm_mysql_server" "mysql" {
  name                = "mysql-server-1"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"

  sku {
    name     = "B_Gen5_2"
    capacity = 2
    tier     = "Basic"
    family   = "Gen5"
  }

  storage_profile {
    storage_mb            = 5120
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
  }

  administrator_login          = "mysqladmin"
  administrator_login_password = "1YAKYohIpL64Vbw2d08s8wOYhuminA371ogM"
  version                      = "5.7"
  ssl_enforcement              = "Disabled"
}
