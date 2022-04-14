#!/usr/bin/env bash

export TF_VAR_client_id=$(/usr/bin/security find-generic-password -w -a "johnnyappleseed" -l "aks-client-id")
export TF_VAR_client_secret=$(/usr/bin/security find-generic-password -w -a "johnnyappleseed" -l "aks-client-secret")
export TF_VAR_environment="prod"

_pwd=$(pwd)

tfenv install 1.1.7
tfenv use 1.1.7

cd terraform/
rm -rf .terraform
terraform init -backend-config=config/${TF_VAR_environment}_backend.tfvars -upgrade=true
terraform fmt -recursive
terraform validate
terraform plan -out=out.plan -var-file=config/${TF_VAR_environment}.tfvars 
terraform apply -parallelism=128 -auto-approve out.plan 
rm -f out.plan

echo "$(terraform output kube_config)" | grep -v EOT > ~/iCloudDrive/Allgemein/kubectl/azurek8s.yaml

cd ${_pwd}

export KUBECONFIG=~/iCloudDrive/Allgemein/kubectl/azurek8s.yaml

kubectl get nodes