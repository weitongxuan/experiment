# 共用k8s
resource "azurerm_resource_group" "k8s" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = var.cluster_name
  location            = azurerm_resource_group.k8s.location
  resource_group_name = azurerm_resource_group.k8s.name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "agentpool"
    node_count = var.agent_count
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
  tags = {
    Environment = "Development"
  }
}

resource "azurerm_dns_zone" "betoolman" {
  name                = "betoolman.com"
  resource_group_name = azurerm_resource_group.k8s.name
}

module "wp_prod" {
  source = "./module/wp"

  helm_name             = "wordpress"
  router_path           = "www"
  resource_group_name   = azurerm_resource_group.k8s.name
  azurerm_dns_zone_name = azurerm_dns_zone.betoolman.name

  depends_on = [
    azurerm_dns_zone.betoolman,
    azurerm_resource_group.k8s,
    azurerm_kubernetes_cluster.k8s
  ]
}

terraform {
  backend "remote" {
    organization = "simonwei"

    workspaces {
      name = "test"
    }
  }
}