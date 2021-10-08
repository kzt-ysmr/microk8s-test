
# MicroK8s Test

This repo includes Terraform scripts for instantly testing microk8s.  An EC2 server with an elastic IP will be provisioned in which the microk8s command is available.

## CLI Prerequisities

* AWS CLI (w/ a profile to use)
* Terraform CLI
* ssh
* ssh-keygen
* jq

## A Sample Dialog

```
$ cd iac

$ ./operations/init.sh > /dev/null
+ : Change Directory
++ readlink -f ./operations/init.sh
++ xargs dirname
+ cd /c/microk8s-test/iac/operations/..
+ : Constants
+ export workspace=test
+ workspace=test
+ : Initializations
+ terraform init
+ : Create Test Workspace
+ terraform workspace new test
+ : Generate An SSH Key-Pair
+ ssh-keygen -t rsa -f .ssh/test-kp-backend-microk8s -N ''

$ terraform apply -var profile=${profile} -var region=${region} -auto-approve > /dev/null

$ ./operations/connect.sh
+ : Change Directory
++ readlink -f ./operations/connect.sh
++ xargs dirname
+ cd /c/microk8s-test/iac/operations/..
+ : Constants
+ export workspace=test
+ workspace=test
+ export user_name=ubuntu
+ user_name=ubuntu
+ export eip=aws_eip.backend
+ eip=aws_eip.backend
+ export public_ip_path=public_ip
+ public_ip_path=public_ip
+ : Helpers
+ : Connect
++ get_resource_property aws_eip.backend public_ip
++ local resource=aws_eip.backend
++ shift
++ local property_path=public_ip
++ shift
++ terraform show -json
++ jq -r '.values.root_module.resources[] | select( .address == "aws_eip.backend" ) | .values.public_ip'
+ ssh -i ./.ssh/test-kp-backend-microk8s -l ubuntu 13.210.15.122
The authenticity of host '13.210.15.122 (13.210.15.122)' can't be established.
ECDSA key fingerprint is SHA256:YZyz1/Fqznrz3m/1jt8UuPpj4OEuq2hOcnPYGT3VK0k.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '13.210.15.122' (ECDSA) to the list of known hosts.
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.11.0-1019-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Fri Oct  8 11:59:04 UTC 2021

  System load:  0.78              Processes:             155
  Usage of /:   31.5% of 7.69GB   Users logged in:       0
  Memory usage: 5%                IPv4 address for ens5: 172.16.10.61
  Swap usage:   0%


1 update can be applied immediately.
To see these additional updates run: apt list --upgradable


Last login: Fri Oct  8 11:56:50 2021 from xxx.xxx.xxx.xxx
ubuntu@ip-172-16-10-61:~$ microk8s status
microk8s is running
high-availability: no
  datastore master nodes: 127.0.0.1:19001
  datastore standby nodes: none
addons:
  enabled:
    dns                  # CoreDNS
    ha-cluster           # Configure high availability on the current node
  disabled:
    ambassador           # Ambassador API Gateway and Ingress
    cilium               # SDN, fast with full network policy
    dashboard            # The Kubernetes dashboard
    fluentd              # Elasticsearch-Fluentd-Kibana logging and monitoring
    gpu                  # Automatic enablement of Nvidia CUDA
    helm                 # Helm 2 - the package manager for Kubernetes
    helm3                # Helm 3 - Kubernetes package manager
    host-access          # Allow Pods connecting to Host services smoothly
    ingress              # Ingress controller for external access
    istio                # Core Istio service mesh services
    jaeger               # Kubernetes Jaeger operator with its simple config
    kata                 # Kata Containers is a secure runtime with lightweight VMS
    keda                 # Kubernetes-based Event Driven Autoscaling
    knative              # The Knative framework on Kubernetes.
    kubeflow             # Kubeflow for easy ML deployments
    linkerd              # Linkerd is a service mesh for Kubernetes and other frameworks
    metallb              # Loadbalancer for your Kubernetes cluster
    metrics-server       # K8s Metrics Server for API access to service metrics
    multus               # Multus CNI enables attaching multiple network interfaces to pods
    openebs              # OpenEBS is the open-source storage solution for Kubernetes
    openfaas             # openfaas serverless framework
    portainer            # Portainer UI for your Kubernetes cluster
    prometheus           # Prometheus operator for monitoring and logging
    rbac                 # Role-Based Access Control for authorisation
    registry             # Private image registry exposed on localhost:32000
    storage              # Storage class; allocates storage from host directory
    traefik              # traefik Ingress controller for external access
ubuntu@ip-172-16-10-61:~$ exit
logout
Connection to 13.210.15.122 closed.
```
