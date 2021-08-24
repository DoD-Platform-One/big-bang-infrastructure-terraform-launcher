registry_credentials = [
    {
        registry = "registry1.dso.mil"
        username = "REPLACE_ME"
        password = "REPLACE_ME"
    }
]

big_bang_manifest_file = "k8s/start.yaml"
custom_helm_values = <<EOF
foo:
  bar: "baz"
EOF
