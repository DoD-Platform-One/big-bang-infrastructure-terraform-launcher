data "kubectl_file_documents" "flux" {
  content = var.custom_flux_file == "" ? file("${path.module}/k8s/flux.yaml") : file(var.custom_flux_file)
}

resource "kubectl_manifest" "flux_deployment" {
  yaml_body = element(data.kubectl_file_documents.flux.documents)
  depends_on = [
    kubernetes_secret.private_registry
  ]
}

