output "external_load_balancer" {
  value = data.external.Wait_for_load_balancer.result
}