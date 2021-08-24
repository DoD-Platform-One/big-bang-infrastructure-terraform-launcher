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

variable "custom_helm_values" {
  description = "Any other yaml custom values you want to provide to the BigBang Helm Chart. They will be added to the secret named 'terraform' in the 'bigbang' namespace. DON'T put 'registryCredentials' here. That's what the 'registry_credentials' variable is for. NOTE: The 'terraform' secret is the first to be applied, so any keys that appear in this will be overwritten if they also appear in a later values file that is used."
  type = string
  default = ""
}

variable "reduce_flux_resources" {
  description = "If true, tweaks resource settings to fit on a smaller machine at the cost of power/speed."
  type    = bool
  default = false
}
