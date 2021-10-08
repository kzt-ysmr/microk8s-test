#!/bin/bash -eux
: Change Directory && {
    cd "$(readlink -f "${0}" | xargs dirname)/.."
}

: Constants && {
    export workspace=${workspace:-test}
    export user_name=ubuntu
    export eip=aws_eip.backend
    export public_ip_path=public_ip
}

: Helpers && {
    get_resource_property () {
        local resource=$1; shift
        local property_path=$1; shift

        terraform show -json | jq -r '.values.root_module.resources[] | select( .address == "'${resource}'" ) | .values.'${property_path}
    }
}

: Connect && {
    ssh -i ./.ssh/${workspace}-kp-backend-microk8s -l ${user_name} $(get_resource_property ${eip} ${public_ip_path})
}
