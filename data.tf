data "azurerm_kubernetes_cluster" "k8s" {
  name                = var.cluster_name
  resource_group_name = var.resource_group_name
  depends_on = [
    azurerm_resource_group.k8s
  ]
}

