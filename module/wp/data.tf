data "kubernetes_service" "wp" {
  metadata {
    name = "wordpress-svc"
    namespace = var.helm_name
  }
  depends_on = [
    helm_release.helm
  ]
}