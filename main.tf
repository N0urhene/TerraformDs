terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "test" {
  name     = "${var.name}-rg"
  location = var.location
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "test" {
  name                = "${var.name}-vnet"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  address_space       = ["10.0.0.0/16"]
}

# création du storage account
resource "azurerm_storage_account" "test" {
  name                     = "sttest1548hf8dd79"
  resource_group_name      = azurerm_resource_group.test.name
  location                 = azurerm_resource_group.test.location
account_tier             = "Standard"
  account_replication_type = "LRS"

}

#Creation du sous_réseau
resource "azurerm_subnet" "test" {
  name = "${var.name}-subnet"
  // location            = azurerm_resource_group.azuretp1.location
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefixes     = ["10.0.2.0/24"]
}

#Creation du sous_réseau
resource "azurerm_subnet" "test2" {
  name = "${var.name}-subnet"
  // location            = azurerm_resource_group.azuretp1.location
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefixes     = ["10.0.2.0/24"]
}

#Creation du sous_réseau
resource "azurerm_subnet" "test3" {
  name = "${var.name}-subnet"
  // location            = azurerm_resource_group.azuretp1.location
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefixes     = ["10.0.2.0/24"]
}

#création de la carte réseau test
resource "azurerm_network_interface" "test" {
  name                = "test-nic"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name

  # configuration de l'adresse tp
  ip_configuration {
    name                          = "${var.name}-nic-ip-config"
    subnet_id                     = azurerm_subnet.test.id
    private_ip_address_allocation = "Dynamic"
  }
}
#création de la carte réseau test2
resource "azurerm_network_interface" "test2" {
  name                = "test2-nic"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name

  # configuration de l'adresse tp
  ip_configuration {
    name                          = "${var.name}-nic-ip-config"
    subnet_id                     = azurerm_subnet.test2.id
    private_ip_address_allocation = "Dynamic"
  }
}
#création de la carte réseau test3
resource "azurerm_network_interface" "test3" {
  name                = "test3-nic"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name

  # configuration de l'adresse tp
  ip_configuration {
    name                          = "${var.name}-nic-ip-config"
    subnet_id                     = azurerm_subnet.test3.id
    private_ip_address_allocation = "Dynamic"
  }
}

# création du storage container
resource "azurerm_storage_container" "test" {
  name                  = "teststoragecontainer"
  storage_account_name  = azurerm_storage_account.test.name
  container_access_type = "private"
}

#configuration de la VPC
resource "azurerm_virtual_machine" "test" {
  name                  = "test-vm"
  resource_group_name   = azurerm_resource_group.test.name
  location              = azurerm_resource_group.test.location
  network_interface_ids = [azurerm_network_interface.test.id]
  vm_size               = "Standard_B1s"

  os_profile {
    computer_name  = "test"
    admin_username = "usertest"
    admin_password = "sd1120@nh/-))"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  storage_os_disk {
    name              = "myosdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    vhd_uri       = "${azurerm_storage_account.test.primary_blob_endpoint}${azurerm_storage_container.test.name}/myosdisk.vhd"

  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

#configuration de la VPC
resource "azurerm_virtual_machine" "test2" {
  name                  = "test2-vm"
  resource_group_name   = azurerm_resource_group.test.name
  location              = azurerm_resource_group.test.location
  network_interface_ids = [azurerm_network_interface.test2.id]
  vm_size               = "Standard_B1s"

  os_profile {
    computer_name  = "test2"
    admin_username = "usertest2"
    admin_password = "sd1120@nh/-))è"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  storage_os_disk {
    name              = "myosdisk2"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    vhd_uri       = "${azurerm_storage_account.test.primary_blob_endpoint}${azurerm_storage_container.test.name}/myosdisk2.vhd"

  }
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

#configuration de la VPC3
resource "azurerm_virtual_machine" "test3" {
  name                  = "test3-vm"
  resource_group_name   = azurerm_resource_group.test.name
  location              = azurerm_resource_group.test.location
  network_interface_ids = [azurerm_network_interface.test3.id]
  vm_size               = "Standard_B1s"

  os_profile {
    computer_name  = "test3"
    admin_username = "usertest3"
    admin_password = "sd1120@nh/-))èé"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  storage_os_disk {
    name              = "myosdisk3"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    vhd_uri           = "${azurerm_storage_account.test.primary_blob_endpoint}${azurerm_storage_container.test.name}/myosdisk3.vhd"
  }
  
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}