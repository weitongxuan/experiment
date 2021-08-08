resource "kubernetes_namespace" "rookNamespace" {
  metadata {
    name = "rook-ceph"
  }
}
resource "helm_release" "rook" {
  name       = "rook-ceph"
  repository = "https://charts.rook.io/release"
  chart      = "rook-ceph"
  namespace = "rook-ceph"

  depends_on = [
    kubernetes_namespace.rookNamespace
  ]
}

resource "helm_release" "rook" {
  name       = "rook-ceph"
  repository = "https://charts.rook.io/release"
  chart      = "rook-ceph-cluster"
  namespace = "rook-ceph"

  values = [
    "${file("values.yaml")}"
  ]
}