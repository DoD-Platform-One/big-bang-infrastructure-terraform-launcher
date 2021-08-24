output "external_load_balancer" {
  description = "JSON object containing information about the external load balancer, such as its IP address"
  value = data.external.Wait_for_load_balancer.result
}