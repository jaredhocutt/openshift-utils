#!/usr/bin/env bash

if [[ $# -lt 2 ]]; then
    echo "Usage: ./deploy_gitlab.sh PROJECT HOSTNAME"
    exit 1
fi

PROJECT=$1
HOSTNAME=$2

ansible-playbook -i 127.0.0.1 -e project_name=${PROJECT} -e hostname=${HOSTNAME} playbook.yaml
