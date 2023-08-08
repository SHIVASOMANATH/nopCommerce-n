provider "azurerm" {
  features {

  }

}
resource "azurerm_resource_group" "terraform" {
  name     = "terraform"
  location = "eastus"
}
resource "azurerm_storage_account" "qttfstate" {
  name                     = "qttfstate"
  resource_group_name      = azurerm_resource_group.terraform.name
  location                 = azurerm_resource_group.terraform.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  //  depends_on               = [azurerm_resource_group.somanath]
}