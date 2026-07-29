#!/usr/bin/env bash
set -euo pipefail

RELEASE="${HELM_RELEASE:-calculator}"
NAMESPACE="${K8S_NAMESPACE:-default}"
TIMEOUT="${HELM_TIMEOUT:-3m}"

echo "Emergency rollback requested for ${RELEASE}"

helm status "${RELEASE}" \
  --namespace "${NAMESPACE}" \
  >/dev/null

helm rollback \
  "${RELEASE}" 0 \
  --namespace "${NAMESPACE}" \
  --wait \
  --timeout "${TIMEOUT}"

./scripts/health-check.sh

echo "Emergency rollback completed successfully."
