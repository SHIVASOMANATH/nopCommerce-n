provider "azurerm" {
  features {
  }
}
resource "azurerm_resource_group" "terraform" {
  name     = "terraform"
  location = "eastus"
}

resource "azurerm_storage_account" "maneesha" {
  name                     = "maneesha"
  resource_group_name      = azurerm_resource_group.terraform.name
  location                 = azurerm_resource_group.terraform.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}
resource "azurerm_ssh_public_key" "maina" {
  name                = "maina"
  resource_group_name = "terraform"
  location            = azurerm_resource_group.terraform.location
  public_key          = file("~/.ssh/id_rsa.pub")
}

resource "azurerm_kubernetes_cluster" "somanath" {
  name                = "somanath"
  location            = azurerm_resource_group.terraform.location
  resource_group_name = azurerm_resource_group.terraform.name
  dns_prefix          = "shiva"

  default_node_pool {
    name       = "mania"
    node_count = 2
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.somanath.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.somanath.kube_config_raw

  sensitive = true
}
