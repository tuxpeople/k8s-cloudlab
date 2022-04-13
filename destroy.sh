#!/usr/bin/env bash

export TF_VAR_client_id=$(/usr/bin/security find-generic-password -w -a "johnnyappleseed" -l "aks-client-id")
export TF_VAR_client_secret=$(/usr/bin/security find-generic-password -w -a "johnnyappleseed" -l "aks-client-secret")

cd terraform

tfenv install 1.1.7
tfenv use 1.1.7

terraform destroy