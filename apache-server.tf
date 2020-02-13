resource "azurerm_public_ip" "apache" {
  name                    = "${var.prefix}-publicip"
  location                = azurerm_resource_group.main.location
  resource_group_name     = azurerm_resource_group.main.name
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30

  tags = {
    environment = "demo"
    owner = "jmartinson@hashicorp.com"
    Name = "Vault Apache Demo Public IP - JacobM"
    DoNotDelete = "true"
  }
}

resource "azurerm_network_interface" "apache" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.apache.id
  }
}

resource "azurerm_virtual_machine" "apache" {
  name                  = "${var.prefix}-apache-vm"
  location              = azurerm_resource_group.main.location
  resource_group_name   = azurerm_resource_group.main.name
  network_interface_ids = ["${azurerm_network_interface.apache.id}"]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true


  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "8-gen2"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "apache"
    admin_username = "azureuser"
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
    Name = "Azure Vault Apache Demo - JacobM"
    DoNotDelete = "true"
  }
}
