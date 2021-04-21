data "kubectl_file_documents" "flux" {
  content = file("${path.module}/k8s/flux.yaml")
}

data "kubectl_file_documents" "flux_light" {
  content = file("${path.module}/k8s/flux_light.yaml")
}

resource "kubectl_manifest" "flux_deployment" {
  count     = var.reduce_flux_resources == true ? 0 : length(data.kubectl_file_documents.flux.documents)
  yaml_body = element(data.kubectl_file_documents.flux.documents, count.index)
  depends_on = [
    kubernetes_secret.private_registry
  ]
}

resource "kubectl_manifest" "flux_deployment_light" {
  count     = var.reduce_flux_resources == true ? length(data.kubectl_file_documents.flux_light.documents) : 0
  yaml_body = element(data.kubectl_file_documents.flux_light.documents, count.index)
  depends_on = [
    kubernetes_secret.private_registry
  ]
}