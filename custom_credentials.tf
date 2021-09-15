resource "kubernetes_secret" "custom_credentials" {
  metadata {
    name      = var.custom_credentials.name
    namespace = var.custom_credentials.namespace
  }

  data = {
    "username" = var.custom_credentials.username
    "password" = var.custom_credentials.password
  }

  depends_on = [
    kubernetes_namespace.namespace_flux_system
  ]
}
