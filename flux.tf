data "kubectl_file_documents" "flux" {
  content = var.custom_flux_file == "" ? file("${path.module}/k8s/flux.yaml") : file(var.custom_flux_file)
}

resource "kubectl_manifest" "flux_deployment" {
  count     = length(data.kubectl_file_documents.flux.documents)
  yaml_body = element(data.kubectl_file_documents.flux.documents, count.index)
  depends_on = [
    kubernetes_secret.private_registry
  ]
}

# resource "kubernetes_config_map" "controller-config" {
#   # count = var.custom_flux_file == "" ? 0 : 1
#   metadata {
#     name = "controller-config"
#     namespace = "flux-system"
#   }

#   data = {
#     ".bashrc" = "${file("${path.module}/configs/.bashrc")}"
#     ".bash_profile" = "${file("${path.module}/configs/.bash_profile")}"
#     "config" = "${file("${path.module}/configs/config")}"
#   }
# }
