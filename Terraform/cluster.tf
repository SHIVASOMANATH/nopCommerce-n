provider "azurerm" {
  features {
  }
}
resource "azurerm_resource_group" "terraform" {
  name     = "terraform1"
  location = "eastus"
}

resource "azurerm_kubernetes_cluster" "somanath" {
  name                = "somanath"
  location            = azurerm_resource_group.terraform.location
  resource_group_name = azurerm_resource_group.terraform.name
  dns_prefix          = "shiva"

  default_node_pool {
    name       = "mania"
    node_count = 1
    vm_size    = "Standard_B2ms"
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
