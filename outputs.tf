output "public_ip_address" {
  value = azurerm_public_ip.main.ip_address
}

data "azurerm_public_ip" "main" {
  name                = "${azurerm_public_ip.main.name}"
  resource_group_name = "${azurerm_virtual_machine.main.resource_group_name}"
}

output "public_ip_address2" {
  value = "${data.azurerm_public_ip.main.ip_address}"
}
