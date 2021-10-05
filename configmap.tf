resource "kubernetes_config_map" "controller-config" {
  metadata {
    name = "controller-config"
    namespace = "flux-system"
  }

  data = {
    ".bashrc" = "${file("${path.module}/configs/.bashrc")}"
    ".bash_profile" = "${file("${path.module}/configs/.bash_profile")}"
    "config" = "${file("${path.module}/configs/config")}"
  }
}