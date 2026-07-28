#!/bin/bash
set -e

TAG=${GO_PIPELINE_COUNTER:-local}

helm upgrade --install calculator ./charts/calculator \
  --set image.tag=${TAG}

kubectl rollout status deployment/calculator