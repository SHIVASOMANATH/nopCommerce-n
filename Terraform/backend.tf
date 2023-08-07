  backend "azurerm" {
    resource_group_name  = "terraform"
    storage_account_name = "qttfstate"
    container_name       = "tfstates"
    key                  = "nopcommerce.tfstate"
  }
provider "azurerm" {
  features {}
  }