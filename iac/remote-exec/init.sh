#!/bin/bash -eux
: Install MicroK8s && {
    sudo snap install microk8s --classic
}

: Firewall Settings && {
    sudo ufw allow in on cni0 && sudo ufw allow out on cni0
    sudo ufw default allow routed
}

: Enable Addons && {
    sudo microk8s enable dns dashboard storage
}

: Users and User Groups Settings && {
    sudo usermod -a -G microk8s ubuntu
}

exit 0
