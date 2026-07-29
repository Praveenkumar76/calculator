#!/usr/bin/env bash
set -euo pipefail

RELEASE="${HELM_RELEASE:-calculator}"
NAMESPACE="${K8S_NAMESPACE:-default}"
CHART="${HELM_CHART:-./charts/calculator}"
TAG="${GO_PIPELINE_COUNTER:-local}"
TIMEOUT="${HELM_TIMEOUT:-3m}"

echo "Deploying release ${RELEASE}"
echo "Image tag: ${TAG}"

ROLLBACK_FLAG=()

if helm upgrade --help | grep -q -- '--rollback-on-failure'; then
  ROLLBACK_FLAG=(--rollback-on-failure)
else
  ROLLBACK_FLAG=(--atomic)
fi

if ! helm upgrade \
  --install "${RELEASE}" "${CHART}" \
  --namespace "${NAMESPACE}" \
  --create-namespace \
  --set-string "image.tag=${TAG}" \
  --wait \
  --timeout "${TIMEOUT}" \
  "${ROLLBACK_FLAG[@]}"
then
  echo "ERROR: Helm deployment failed."
  echo "Helm automatically restored the previous successful release."
  exit 1
fi

if ./scripts/health-check.sh; then
  echo "Deployment completed successfully."
  exit 0
fi

echo "ERROR: Post-deployment health check failed."
echo "Rolling back to the previous Helm revision..."

helm rollback \
  "${RELEASE}" 0 \
  --namespace "${NAMESPACE}" \
  --wait \
  --timeout "${TIMEOUT}"

echo "Verifying the restored deployment..."

if ! ./scripts/health-check.sh; then
  echo "CRITICAL: Rollback completed, but restored application is unhealthy."
  exit 1
fi

echo "Previous successful version restored."
exit 1
