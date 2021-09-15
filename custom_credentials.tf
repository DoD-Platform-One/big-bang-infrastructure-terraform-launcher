locals {
  credentials = var.custom_credentials
}

resource "kubernetes_secret" "custom_credentials" {
  count = length(local.credentials)

  metadata {
    name      = local.credentials[count.index].name
    namespace = local.credentials[count.index].namespace
  }

  data = {
    "username" = local.credentials[count.index].username
    "password" = local.credentials[count.index].password
  }

  depends_on = [
    kubernetes_namespace.namespace_flux_system
  ]
}
