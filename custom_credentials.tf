locals {
  dockerconfigjson = jsonencode({ for r in var.registry_credentials : r.registry => {
    auth = base64encode("${r.username}:${r.password}")
    }
  })
  yaml = yamlencode({ registryCredentials = var.registry_credentials })
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

resource "kubernetes_secret" "bb-common-secret" {
  metadata {
    name      = "terraform"
    namespace = "bigbang"
  }

  data = {
    "values.yaml" = local.yaml
  }

  depends_on = [
    kubernetes_namespace.namespace_bigbang
  ]
}
