variable "kube_conf_file" {
  description = "Path to the KUBECONFIG file to use to connect to the cluster. If the file passed has multiple contexts in it the correct context is expected to already be set in `contexts.current-context`."
  type        = string
  default     = "~/.kube/config"
}

variable "big_bang_manifest_file" {
  description = "Path to the root k8s yaml manifest. Typically contains a Namespace, GitRepository, and Kustomization. See https://repo1.dso.mil/platform-one/quick-start/big-bang/-/blob/master/bigbang/start.yaml for example"
  type        = string
  default     = "k8s/start.yaml"
}

variable "custom_flux_file" {
  description = "Path to the flux file."
  type        = string
  default     = ""
}


variable "registry_credentials" {
  description = "System-wide registry credentials to be applied so Kubernetes can pull container images. Creds for registry1.dso.mil are required, and you can optionally provide any other creds for other private registries as well"
  type = list(object({
    registry = string
    username = string
    password = string
  }))
}

variable "custom_credentials" {
  description = "Any custom credentials needed for custom BigBang implementation"
  type = list(object({
    namespace = string
    name      = string
    username  = string
    password  = string
  }))
  default = []
}