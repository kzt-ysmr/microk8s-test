
# MicroK8s Test

This repo includes Terraform scripts for instantly testing microk8s.  An EC2 server with an elastic IP will be provisioned in which the microk8s command is available.

## CLI Prerequisities

* AWS CLI (w/ a profile to use)
* Terraform CLI
* ssh
* ssh-keygen
* jq

## Dependencies

```
|- provider
|- microk8s
   |- default
      |- networks
   |- backend
      |- networks
      |- instances
```

## Initialization

```
cd iac
```

```
terraform init
terraform workspace new ${workspace}
```

```
ssh-keygen -t rsa -f .ssh/${workspace}-kp-backend-microk8s -N ''
```

## Planning

```
terraform plan -var profile=${profile} -var region=${region}
```

```
terraform plan -var profile=${profile} -var region=${region} -destroy
```

## Connect with SSH

```
ssh -i ./.ssh/${workspace}-kp-backend-microk8s -l ubuntu $(terraform show -json | jq -r '.values.root_module.resources[] | select( .address == "aws_eip.backend" ) | .values.public_ip')
```
