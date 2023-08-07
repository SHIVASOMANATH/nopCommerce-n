provider "azurerm" {
  features {

  }

}
resource "azurerm_resource_group" "somanath" {
  name     = "terraform"
  location = "eastus"
}
resource "azurerm_storage_account" "shivasomanath1995" {
  name                     = "qttfstate"
  resource_group_name      = azurerm_resource_group.somanath.name
  location                 = azurerm_resource_group.somanath.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  //  depends_on               = [azurerm_resource_group.somanath]
}