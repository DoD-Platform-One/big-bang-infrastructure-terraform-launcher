data "kubectl_file_documents" "flux" {
  content = file(var.flux_manifest_file)
}

resource "kubectl_manifest" "flux_deployment" {
  count     = length(data.kubectl_file_documents.flux.documents)
  yaml_body = element(data.kubectl_file_documents.flux.documents, count.index)
  depends_on = [
    kubernetes_secret.private_registry
  ]
}
