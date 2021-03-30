
variable "kube_conf_file" {
  type    = string
  default = "~/.kube/config"
}

variable "flux_manifest_file" {
    type = string
    default = "k8s/flux.yaml"
}

variable "big_bang_manifest_file" {
    type = string
    default = "k8s/start.yaml"
}

variable "registry_credentials" {
  type = list(object({
    domain   = string
    username = string
    password = string
  }))
}