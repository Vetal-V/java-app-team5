# By VovaPfaifer for Dev-ops team5
#terrafor code to make Resorce group .. vm
# Configure the Microsoft Azure Provider
provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x. 
    # If you're using version 1.x, the "features" block is not allowed.
    version = "~>2.0"
    features {}

    subscription_id = var.SUBSCRIPTION_ID #find it there https://www.terraform.io/docs/providers/azurerm/guides/service_principal_client_secret.html
    client_id       = var.CLIENT_ID
    client_secret   = var.CLIENT_SECRET
    tenant_id       = var.TENANT_ID
}

# Create a resource group if it doesn't exist
resource "azurerm_resource_group" "myterraformgroup" {
    name     = "prd-vm-rg-eastus-crashcourse"
    location = "eastus"

    tags = {
        environment = "Terraform Demo"
    }
}

# Create virtual network
resource "azurerm_virtual_network" "myterraformnetwork" {
    name                = "prd-virtualnetwork-eastus-crashcourse"
    address_space       = ["10.0.0.0/16"]
    location            = "eastus"
    resource_group_name = azurerm_resource_group.myterraformgroup.name #16 line "myterraformgroup"

    tags = {
        environment = "Terraform Demo"
    }
}

# Create subnet
resource "azurerm_subnet" "myterraformsubnet" {
    name                 = "prd-subnet-eastus-crashcourse"
    resource_group_name  = azurerm_resource_group.myterraformgroup.name #16 "myterraformgroup"
    virtual_network_name = azurerm_virtual_network.myterraformnetwork.name #26 "myterraformnetwork"
    address_prefix       = "10.0.1.0/24"
}

# Create public IPs
resource "azurerm_public_ip" "myterraformpublicip" {
    count                        = 3
    name                         = "prd-publicip${count.index}-eastus-crashcourse"
    location                     = "eastus"
    resource_group_name          = azurerm_resource_group.myterraformgroup.name #16 line "myterraformgroup"
    allocation_method            = "Static"

    tags = {
        environment = "Terraform Demo"
    }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "myterraformnsg" {
    name                = "prd-network-sg-eastus-crashcourse"
    location            = "eastus"
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
    count               = 3
    name                = "prd-nic${count.index}-eastus-crashcourse"
    location            = "eastus"
    resource_group_name = azurerm_resource_group.myterraformgroup.name #16 line "myterraformgroup"

    ip_configuration {
        name                          = "prd-nic-config-eastus-crashcourse"
        subnet_id                     = azurerm_subnet.myterraformsubnet.id  # 38 line "myterraformsubnet"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.myterraformpublicip[count.index].id  #46 line "myterraformpublicip"
    }

    tags = {
        environment = "Terraform Demo"
    }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
    count                     = 3
    network_interface_id      = azurerm_network_interface.myterraformnic[count.index].id #81 line "myterraformnic"
    network_security_group_id = azurerm_network_security_group.myterraformnsg.id # 58 line"myterraformnsg"
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "mystorageaccount" {
    name                        = "storageaccount1cc"
    resource_group_name         = azurerm_resource_group.myterraformgroup.name #16 line myterraformgroup
    location                    = "eastus"
    account_tier                = "Standard" #choose
    account_replication_type    = "LRS"

    tags = {
        environment = "Terraform Demo"
    }
}

# Create virtual machines
resource "azurerm_linux_virtual_machine" "myterraformvm" {
    count                 = 3
    name                  = "prd-vm${count.index}-eastus-crashcourse"
    location              = "eastus"
    resource_group_name   = azurerm_resource_group.myterraformgroup.name #16 line myterraformgroup
    network_interface_ids = [element(azurerm_network_interface.myterraformnic.*.id, count.index)] #81 line
    size                  = "Standard_B1s" #choose 8.7$

    os_disk {
        name              = "prd-osdisk${count.index}-eastus-crashcourse"
        caching           = "ReadWrite"
        storage_account_type = "Standard_LRS" #choose
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS" #newest version
        version   = "latest"
    }

    computer_name  = "myvm"
    admin_username = var.ADMIN_USERNAME
    admin_password = var.ADMIN_PASSWORD
    disable_password_authentication = false

    #no ssh
    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.mystorageaccount.primary_blob_endpoint
    }

    tags = {
        environment = "Terraform Demo"
    }
}
