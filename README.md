# Big Bang Terraform Start

## Prerequisites

- Linux or MacOS (runs a bash script to return information about Istio's LoadBalancers)
- `terraform`
- `kubectl`
- `jq`

## Getting Started

An example of a project that uses this Terraform module can be found [here](https://repo1.dso.mil/platform-one/quick-start/big-bang).

## Instructions

### Using a vars file:

```bash
# Copy and edit with your values
cp terraform.tfvars.example terraform.tfvars 

terraform init
terraform plan
terraform apply
```

### Using environment variables:

```bash
# Update with your values
export TF_VAR_registry_credentials='[{registry="registry1.dso.mil",username="REPLACE_ME",password="REPLACE_ME"}]'

#Optional: Reduce flux resource requests for edge/resource constrained environments
export TF_VAR_reduce_flux_resources=true

terraform init
terraform plan
terraform apply
```

### Using inline arguments:

```bash
# Update with your values inline
terraform init
terraform plan -var 'registry_credentials=[{registry="registry1.dso.mil",username="REPLACE_ME",password="REPLACE_ME"}]'
terraform apply -var 'registry_credentials=[{regsitry="registry1.dso.mil",username="REPLACE_ME",password="REPLACE_ME"}]'
```
