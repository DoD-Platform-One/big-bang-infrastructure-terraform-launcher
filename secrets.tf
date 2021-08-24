locals {
  dockerconfigjson = jsonencode({ for r in var.registry_credentials : r.registry => {
    auth = base64encode("${r.username}:${r.password}")
    }
  })
  registryCredentialsYaml = yamlencode({ registryCredentials = var.registry_credentials })
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

// TODO: Rename this resource to something like 'bb-terraform'. There's a different secret that gets created called 'common-bb' and this isn't it. Renaming the resource is likely a breaking change, but is probably a very minor one.
resource "kubernetes_secret" "bb-common-secret" {
  metadata {
    name      = "terraform"
    namespace = "bigbang"
  }

  data = {
    // Definitely apply the registryCredentials, but also maybe apply custom helm values if the variable isn't empty
    "values.yaml" = var.custom_helm_values == "" ? local.registryCredentialsYaml : "${local.registryCredentialsYaml}\n${var.custom_helm_values}"
  }

  depends_on = [
    kubernetes_namespace.namespace_bigbang
  ]
}
