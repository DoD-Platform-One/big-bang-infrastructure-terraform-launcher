variable "big_bang_manifest_file" {
    type = string
    default = "k8s/start.yaml"
}

variable "registry_credentials" {
  type = list(object({
    registry   = string
    username = string
    password = string
  }))
}