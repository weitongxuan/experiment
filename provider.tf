provider "azurerm" {
  features {}

  subscription_id = "fffffe86-a136-4b1f-8313-0e91f950360e"
  client_id       = "fd158a7b-9f64-4956-bab3-7341307c5235"
  client_secret   = "DeJMYaQw1~lxcd0byB41-Q.U38o.C9nhA~"
  tenant_id       = "2cf4248e-4836-4202-b796-9a1589ff4613"
}

provider "helm" {
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.k8s.kube_config.0.host
    client_key             = base64decode(data.azurerm_kubernetes_cluster.k8s.kube_config.0.client_key)
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.k8s.kube_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.k8s.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate)
}