## Setup environment
Required environment variables:
```
export TF_VAR_SELECTEL_ACCOUNT=12345
export TF_VAR_PROJ_ID=3e566b85c6884837b03ba11af62d22ff
export TF_VAR_USER=myuser
export TF_VAR_PASSWORD=mypassword
```


## Creating new server
1. Copy `/servers/_template` to `servers/new.server.fqdn`
2. Fill `/servers/new.server.fqdn/terraform.tfvars`

## Apply server:
```
cd servers/server1.example.com
terraform plan -var-file=../../global.tfvars
terraform apply -var-file=../../global.tfvars
```

