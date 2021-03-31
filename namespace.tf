resource "kubernetes_namespace" "namespace_flux_system" {
  metadata {
    name = "flux-system"
  }

  lifecycle {
    ignore_changes = [
      metadata[0].labels,
    ]
  }
}

resource "kubernetes_namespace" "namespace_bigbang" {
  metadata {
    name = "bigbang"
  }

  lifecycle {
    ignore_changes = [
      metadata[0].labels,
    ]
  }
}
