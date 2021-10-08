
# MicroK8s Test Project

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
