output "external_load_balancer" {
  description = <<EOF
JSON array with information on all LoadBalancer services in the istio-system namespace. Example output:
```
[
  {
    "name": "public-ingressgateway",
    "ip": "192.0.2.0",
    "hostname": "null"
  },
  {...}
]
```
EOF
  value = base64decode(data.external.Wait_for_load_balancer.result.encoded)
}
