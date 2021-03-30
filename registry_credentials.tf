locals {
  dockerconfigjson = jsonencode({ for r in var.registry_credentials : r.domain => {
    auth = base64encode("${r.username}:${r.password}")
    }
  })
}

resource "kubernetes_secret" "private_registry" {
  metadata {
    name      = "private-registry"
    namespace = "flux-system"
  }

  data = {
    ".dockerconfigjson" = "{\"auths\": ${local.dockerconfigjson}}"
  }

  type = "kubernetes.io/dockerconfigjson"
  depends_on = [
    kubernetes_namespace.namespace_flux_system
  ]
}
