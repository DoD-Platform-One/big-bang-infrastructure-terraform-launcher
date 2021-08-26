output "external_load_balancer" {
  description = "JSON array with information on all LoadBalancer services in the istio-system namespace, Keys are 'name', 'ip', and 'hostname'"
  value = data.external.Wait_for_load_balancer.result
}