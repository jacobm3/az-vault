
resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-rg"
  location = "West US 2"
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "main" {
  name                  = "${var.prefix}-vm"
  location              = azurerm_resource_group.main.location
  resource_group_name   = azurerm_resource_group.main.name
  network_interface_ids = ["${azurerm_network_interface.main.id}"]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true


  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "vault-server"
    admin_username = "ubuntu"
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
            path     = "/home/ubuntu/.ssh/authorized_keys"
            key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDYNkA7EvTrnUuB3JmCjlJ+FD3BSs8sgBEgpk/ujDGXdvMKgiNMAUuRvAtnMo4ilEWNXQXGBQKp3/wE3+yXUDIq4Ve8MkYdn6JQviazqlM9L4JCmZtVEKn7cMo91MR0t82IdfbcI2hM3zgDrXmV/F1Sp9W8z4+TLTNgCmA3d61jvT2YIIxO6ag8zIwGjqwh9+r9lwa0eNRAdqtyO/GXcDAy1UHZPdt3tsTt7Ea2opmMJAWfAYAcw70fqS+9lcPtwvTXlxEoG5BYcDZMSEwmbNlR6Z/rfoGNb91MsspjSwxQwhUj+lILc5W3p3wdtLEiRqSuhr/BZYTTjla4yTI9U5qJ"
        }
  }
  
  tags = {
    environment = "demo"
    owner = "jmartinson@hashicorp.com"
    Name = "Azure Vault Demo - JacobM"
  }
}
