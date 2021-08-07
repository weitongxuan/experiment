resource "helm_release" "helm" {
    name       = var.helm_name
    chart      = "helms/wp"
}
// asdasd
resource "azurerm_dns_a_record" "betoolman" {
  name                = var.router_path
  zone_name           = var.azurerm_dns_zone_name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [data.kubernetes_service.wp.status.0.load_balancer.0.ingress.0.ip]
  depends_on = [
    helm_release.helm
  ]
}

