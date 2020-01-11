
  module "win10" {
    source              = "./terraform-azurerm-compute"
    resource_group_name = azurerm_resource_group.main.name
    location            = "westus2"
    vm_hostname         = "jmartinson-win"
    admin_password      = "Com@#$%asdfADSFrd!"
    public_ip_dns       = ["jmartinson-win-10-ip"]
    nb_public_ip        = "1"
    remote_port         = "3389"
    nb_instances        = "1"
    vm_os_publisher     = "MicrosoftWindowsDesktop"
    vm_os_offer         = "Windows-10"
    vm_os_sku           = "19h1-ent"
    vm_size             = "Standard_DS2_V2"
    vnet_subnet_id      = azurerm_subnet.internal.id
  }
