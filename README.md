# Big Bang Terraform Start

### Using `terraform.tfvars`:

```bash
# Copy and edit with your values
cp terraform.tfvars.example terraform.tfvars 

terraform init
terraform plan
terraform apply
```

### Using environment variables

```bash
# Update with your values
export TF_VAR_registry_credentials='[{domain="registry1.dso.mil",username="REPLACE_ME",password="REPLACE_ME"}]'

terraform init
terraform plan
terraform apply
```

### Using inline arguments:

```bash
# Update with your values inline
terraform init
terraform plan -var 'registry_credentials=[{domain="registry1.dso.mil",username="REPLACE_ME",password="REPLACE_ME"}]'
terraform apply -var 'registry_credentials=[{domain="registry1.dso.mil",username="REPLACE_ME",password="REPLACE_ME"}]'
```
