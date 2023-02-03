#!/bin/bash

# Installs OpenShift GitOps Operator and Deploys Argo CD Instance

SCRIPT_BASE_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

echo "Deploying OpenShit GitOps..."
helm dependency update "${SCRIPT_BASE_DIR}/../charts/operator"
helm upgrade -i -n openshift-operators openshift-gitops "${SCRIPT_BASE_DIR}/../charts/operator" -f "${SCRIPT_BASE_DIR}/values-init.yaml"

# Wait for argocds.argoproj.io CRD Deployment

echo "Waiting for crd/argocds.argoproj.io to become available..."
until kubectl wait crd/argocds.argoproj.io --for condition=established &>/dev/null; do sleep 5; done

echo "Creating Management Stack GitOps Namespace..."
helm dependency update "${SCRIPT_BASE_DIR}/../charts/namespace"
helm upgrade -i management-stack-namespace "${SCRIPT_BASE_DIR}/../charts/namespace" -f "${SCRIPT_BASE_DIR}/values-init.yaml"

echo "Deploying Argo CD..."
helm dependency update "${SCRIPT_BASE_DIR}/../charts/argocd"
helm upgrade -i -n management-stack-gitops argocd "${SCRIPT_BASE_DIR}/../charts/argocd"
