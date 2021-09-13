data "kubectl_file_documents" "flux" {
  content = file("${path.module}/k8s/flux.yaml")
}

data "kubectl_file_documents" "flux_light" {
  content = file("${path.module}/k8s/flux_light.yaml")
}

data "kubectl_file_documents" "flux_custom" {
  content = file(var.flux_file)
}

resource "kubectl_manifest" "flux_deployment" {
  count     = var.reduce_flux_resources == true && var.flux_custom == false ? 0 : length(data.kubectl_file_documents.flux.documents)
  yaml_body = element(data.kubectl_file_documents.flux.documents, count.index)
  depends_on = [
    kubernetes_secret.private_registry
  ]
}

resource "kubectl_manifest" "flux_deployment_light" {
  count     = var.reduce_flux_resources == true && var.flux_custom == false ? length(data.kubectl_file_documents.flux_light.documents) : 0
  yaml_body = element(data.kubectl_file_documents.flux_light.documents, count.index)
  depends_on = [
    kubernetes_secret.private_registry
  ]
}

resource "kubectl_manifest" "flux_deployment_cutom" {
  count     = var.flux_custom == true ? length(data.kubectl_file_documents.flux_custom.documents) : 0
  yaml_body = element(data.kubectl_file_documents.flux_custom.documents, count.index)
  depends_on = [
    kubernetes_secret.private_registry
  ]
}