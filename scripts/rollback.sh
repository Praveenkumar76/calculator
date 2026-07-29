#!/bin/bash
set -e

DEPLOYMENT_NAME="calculator"

echo "======================================"
echo " Kubernetes Rollback Pipeline"
echo "======================================"

echo
echo "Available revisions:"
kubectl rollout history deployment/${DEPLOYMENT_NAME}

echo
echo "Rolling back deployment..."

kubectl rollout undo deployment/${DEPLOYMENT_NAME}

echo
echo "Waiting for rollout to complete..."

kubectl rollout status deployment/${DEPLOYMENT_NAME}

echo
echo "Current rollout history:"
kubectl rollout history deployment/${DEPLOYMENT_NAME}

echo
echo "Rollback completed successfully."