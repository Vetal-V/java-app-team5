#Standart tf file for creating 3vms without loadbalancer
#TO CHANGE
#NO proper credential
#disk require no standarT but standarD
#Vm resource 2 type //_1, _2//

# By VovaPfaifer for Dev-ops team5
#terrafor code to make Resorce group .. vm
# Configure the Microsoft Azure Provider
provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x. 
    # If you're using version 1.x, the "features" block is not allowed.
    version = "~>2.0"
    features {}

    subscription_id = "xxxxxxxxxxxxxxxxx"
    client_id       = "xxxxxxxxxxxx"
    client_secret   = "xxxxxxxxx"
    tenant_id       = "xxxxx"
}

# Create a resource group if it doesn't exist
resource "azurerm_resource_group" "myterraformgroup" {
    name     = "myResourceGroup"
    location = "easteu"

    tags = {
        environment = "Terraform Demo"
    }
}

# Create virtual network
resource "azurerm_virtual_network" "myterraformnetwork" {
    name                = "myVnet"
    address_space       = ["10.0.0.0/16"]
    location            = "easteu"
    resource_group_name = azurerm_resource_group.myterraformgroup.name #16 line "myterraformgroup"

    tags = {
        environment = "Terraform Demo"
    }
}

# Create subnet
resource "azurerm_subnet" "myterraformsubnet" {
    name                 = "mySubnet"
    resource_group_name  = azurerm_resource_group.myterraformgroup.name #16 "myterraformgroup"
    virtual_network_name = azurerm_virtual_network.myterraformnetwork.name #26 "myterraformnetwork"
    address_prefix       = "10.0.1.0/24"
}

# Create public IPs
resource "azurerm_public_ip" "myterraformpublicip" {
    name                         = "myPublicIP"
    location                     = "easteu"
    resource_group_name          = azurerm_resource_group.myterraformgroup.name #16 line "myterraformgroup"
    allocation_method            = "Dynamic"

    tags = {
        environment = "Terraform Demo"
    }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "myterraformnsg" {
    name                = "myNetworkSecurityGroup"
    location            = "easteu"
    resource_group_name = azurerm_resource_group.myterraformgroup.name
    
    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "Terraform Demo"
    }
}

# Create network interface
resource "azurerm_network_interface" "myterraformnic" {
    name                      = "myNIC"
    location                  = "easteu"
    resource_group_name       = azurerm_resource_group.myterraformgroup.name #16 line "myterraformgroup"

    ip_configuration {
        name                          = "myNicConfiguration"
        subnet_id                     = azurerm_subnet.myterraformsubnet.id  # 38 line "myterraformsubnet"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.myterraformpublicip.id  #46 line "myterraformpublicip"
    }

    tags = {
        environment = "Terraform Demo"
    }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" { 
    network_interface_id      = azurerm_network_interface.myterraformnic.id #81 line "myterraformnic"
    network_security_group_id = azurerm_network_security_group.myterraformnsg.id # 58 line"myterraformnsg"
}

# Generate random text for a unique storage account name
resource "random_id" "randomId" {
    keepers = {
        # Generate a new ID only when a new resource group is defined
        resource_group = azurerm_resource_group.myterraformgroup.name
    }
    
    byte_length = 8
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "mystorageaccount" {
    name                        = "diag${random_id.randomId.hex}"
    resource_group_name         = azurerm_resource_group.myterraformgroup.name #16 line myterraformgroup
    location                    = "easteu"
    account_tier                = "Standard" #choose
    account_replication_type    = "LRS"

    tags = {
        environment = "Terraform Demo"
    }
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "myterraformvm" {
    name                  = "myVM"
    location              = "easteu"
    resource_group_name   = azurerm_resource_group.myterraformgroup.name #16 line myterraformgroup
    network_interface_ids = [azurerm_network_interface.myterraformnic.id] #81 line
    size                  = "Standard B1s" #choose 8.7$

    os_disk {
        name              = "myOsDisk"
        caching           = "ReadWrite"
        storage_account_type = "Standart_LRS" #choose
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04.0-LTS" #newest version 
        version   = "latest"
    }

    computer_name  = "myvm"
    admin_username = "machine_front" #new user name 
    disable_password_authentication = true #disable pass or  admin_password = "..."
        
    admin_ssh_key {
        username       = "machine_front" #line 149
        public_key     = file("/home/machine_front/.ssh/authorized_keys") #change .../azureuser/ on your
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.mystorageaccount.primary_blob_endpoint
    }

    tags = {
        environment = "Terraform Demo"
    }
    }
    # Create virtual machine number2
resource "azurerm_linux_virtual_machine" "myterraformvm_1" {
    name                  = "myVM1"
    location              = "easteu"
    resource_group_name   = azurerm_resource_group.myterraformgroup.name #16 line myterraformgroup
    network_interface_ids = [azurerm_network_interface.myterraformnic.id] #81 line
    size                  = "Standard B1s" #choose 8.7$

    os_disk {
        name              = "myOsDisk"
        caching           = "ReadWrite"
        storage_account_type = "Standart_LRS" #choose
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04.0-LTS" #newest version 
        version   = "latest"
    }

    computer_name  = "myvm1"
    admin_username = "machine_back_1" #new user name 
    disable_password_authentication = true #disable pass or  admin_password = "..."
        
    admin_ssh_key {
        username       = "machine_back_1" #line 149
        public_key     = file("/home/machine_back_1/.ssh/authorized_keys") #change .../azureuser/ on your
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.mystorageaccount.primary_blob_endpoint
    }

    tags = {
        environment = "Terraform Demo"
    }
    }
    # Create virtual machine number 3
resource "azurerm_linux_virtual_machine" "myterraformv_2" {
    name                  = "myVM3"
    location              = "easteu"
    resource_group_name   = azurerm_resource_group.myterraformgroup.name #16 line myterraformgroup
    network_interface_ids = [azurerm_network_interface.myterraformnic.id] #81 line
    size                  = "Standard B1s" #choose 8.7 $

    os_disk {
        name              = "myOsDisk"
        caching           = "ReadWrite"
        storage_account_type = "Standart_LRS" #choose
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04.0-LTS" #newest version 
        version   = "latest"
    }

    computer_name  = "myvm2"
    admin_username = "machine_back_2" #new user name 
    disable_password_authentication = true #disable pass or  admin_password = "..."
        
    admin_ssh_key {
        username       = "machine_back_2" #line 149
        public_key     = file("/home/machine_back_2/.ssh/authorized_keys") #change .../azureuser/ on your
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.mystorageaccount.primary_blob_endpoint
    }

    tags = {
        environment = "Terraform Demo"
    }
}
