#!/bin/bash
set -e

DEPLOYMENT_NAME="calculator"

if [ -z "$1" ]; then
    echo "Usage: $0 <revision>"
    echo
    kubectl rollout history deployment/${DEPLOYMENT_NAME}
    exit 1
fi

REVISION=$1

echo "Available revisions:"
kubectl rollout history deployment/${DEPLOYMENT_NAME}

echo
echo "Rolling back to revision ${REVISION}"

kubectl rollout undo deployment/${DEPLOYMENT_NAME} --to-revision=${REVISION}

kubectl rollout status deployment/${DEPLOYMENT_NAME}

echo "Rollback successful."