#!/usr/bin/env bash

if [[ $# -lt 2 ]]; then
    echo "Usage: ./run.sh GITLAB_PROJECT GITLAB_HOSTNAME"
    echo
    echo "    Example: ./run.sh gitlab gitlab.apps.openshift.example.com"

    exit 1
fi

echo "This script assumes you are logged in using the 'oc' client as a user"
echo "with the 'cluster-admin' role."
echo
echo "If you are not logged, terminate this script, login using the 'oc' client"
echo "and re-run this script."
echo

OCP_SERVER=$(oc whoami --show-server)

echo "Continue logged in to server ${OCP_SERVER}?"
select CONTINUE in "yes" "no"
do
  case $CONTINUE in
    yes )
    echo
    echo "Deploying GitLab on ${OCP_SERVER}..."
    echo
    break
    ;;

    no )
    echo
    echo "Login to the OpenShift server you would like to deploy to and re-run this script"
    echo
    exit
    ;;
  esac
done

GITLAB_PROJECT=$1
GITLAB_HOSTNAME=$2

ansible-playbook -i 127.0.0.1 -e project_name=${GITLAB_PROJECT} -e hostname=${GITLAB_HOSTNAME} playbook.yml -v
