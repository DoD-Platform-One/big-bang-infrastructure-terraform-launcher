variable "kube_conf_file" {
  description = "Path to the KUBECONFIG file to use to connect to the cluster. If the file passed has multiple contexts in it the correct context is expected to already be set in `contexts.current-context`."
  type    = string
  default = "~/.kube/config"
}

variable "big_bang_manifest_file" {
  description = "Path to the root k8s yaml manifest. Typically contains a Namespace, GitRepository, and Kustomization. See https://repo1.dso.mil/platform-one/quick-start/big-bang/-/blob/master/bigbang/start.yaml for example"
  type    = string
  default = "k8s/start.yaml"
}

variable "registry_credentials" {
  description = "System-wide registry credentials to be applied so Kubernetes can pull container images. Creds for registry1.dso.mil are required, and you can optionally provide any other creds for other private registries as well"
  type = list(object({
    registry = string
    username = string
    password = string
  }))
}

variable "reduce_flux_resources" {
  description = "DEPRECATED - Used to tweak resource settings to fit on a smaller machine, but the new Flux deployment already uses the smaller values. `flux.yaml` and `flux_light.yaml` are now identical files."
  type    = bool
  default = false
}
