
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
./operations/init.sh
```

## Planning

The Terraform scripts require AWS profile and region settings (e.g. `profile=my_profile` / `region=ap-southeast-2`).

```
terraform plan -var profile=${profile} -var region=${region}
```

## Connect with SSH

```
./operations/connect.sh
```
