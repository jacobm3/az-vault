  module "winserver" {
    source              = "./terraform-azurerm-compute"
    resource_group_name = azurerm_resource_group.main.name
    location            = "westus2"
    vm_hostname         = "jacobm-winsrv"
    admin_password      = "Com@#$%asdfADSFrd!"
    public_ip_dns       = ["jmartinson-vault-win-server-ip"]
    nb_public_ip        = "1"
    remote_port         = "3389"
    nb_instances        = "1"
    vm_os_publisher     = "MicrosoftWindowsServer"
    vm_os_offer         = "WindowsServer"
    vm_os_sku           = "2012-R2-Datacenter"
    vm_size             = "Standard_DS2_V2"
    vnet_subnet_id      = azurerm_subnet.internal.id
  }

  module "win10" {
    source              = "./terraform-azurerm-compute"
    resource_group_name = azurerm_resource_group.main.name
    location            = "westus2"
    vm_hostname         = "jacobm-win10"
    admin_password      = "Com@#$%asdfADSFrd!"
    public_ip_dns       = ["jmartinson-vault-win-10-ip"]
    nb_public_ip        = "1"
    remote_port         = "3389"
    nb_instances        = "1"
    vm_os_publisher     = "MicrosoftWindowsDesktop"
    vm_os_offer         = "Windows-10"
    vm_os_sku           = "19h1-ent"
    vm_size             = "Standard_DS2_V2"
    vnet_subnet_id      = azurerm_subnet.internal.id
  }
