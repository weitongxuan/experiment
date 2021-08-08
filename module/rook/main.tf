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
  wait = true
  wait_for_jobs = true
}

resource "helm_release" "rookCluster" {
  name       = "rook-ceph-cluster"
  repository = "https://charts.rook.io/release"
  chart      = "rook-ceph-cluster"
  namespace = "rook-ceph"

  values = [
    "${file("module/rook/values.yaml")}"
  ]

  depends_on = [
    kubernetes_namespace.rookNamespace,
    helm_release.rook
  ]
  wait = true
  wait_for_jobs = true
}