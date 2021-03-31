data "kubectl_file_documents" "bigbang" {
  content = file(var.big_bang_manifest_file)
}

resource "kubectl_manifest" "big_bang" {
  count     = length(data.kubectl_file_documents.bigbang.documents)
  yaml_body = element(data.kubectl_file_documents.bigbang.documents, count.index)
  depends_on = [
    kubectl_manifest.flux_deployment,
    kubernetes_secret.bb-common-secret
  ]
}
