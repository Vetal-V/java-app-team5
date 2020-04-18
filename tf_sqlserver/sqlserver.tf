provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x. 
  # If you are using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
  
  subscription_id = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  client_id       = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  client_secret   = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  tenant_id       = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}

resource "azurerm_resource_group" "crashdb_rg" {
  name     = "prd-sqlserver-rg-eastus-crashcourse"
  location = "eastus"
}

resource "azurerm_sql_server" "crashdb_sql_server" {
  name                         = "prd-sqlserver-eastus-crashcourse"
  resource_group_name          = azurerm_resource_group.crashdb_rg.name
  location                     = azurerm_resource_group.crashdb_rg.location
  version                      = "12.0"
  administrator_login          = "crashadmin"
  administrator_login_password = "wPZ5GX%517@h*8E2!u"

  tags = {
    environment = "production crashcourse"
  }
}

resource "azurerm_sql_firewall_rule" "crashdb_firewall_rule" {
  name                = "allow-azure-services"
  resource_group_name = azurerm_resource_group.crashdb_rg.name
  server_name         = azurerm_sql_server.crashdb_sql_server.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}
