#!/bin/bash -eux
: Change Directory && {
    cd "$(readlink -f "${0}" | xargs dirname)/.."
}

: Constants && {
    export workspace=${workspace:-test}
}

: Initializations && {
    terraform init
}

: Create Test Workspace && {
    terraform workspace new ${workspace}
}

: Generate An SSH Key-Pair && {
    ssh-keygen -t rsa -f .ssh/${workspace}-kp-backend-microk8s -N ''
}
