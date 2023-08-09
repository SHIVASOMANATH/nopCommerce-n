terraform {
  backend "azurerm" {
    resource_group_name  = "TFContainer"
    storage_account_name = "shivatfaccount"
    container_name       = "terraformstatefiles"
    key                  = "nop.dev.deploy.tfstate"
  }
}
