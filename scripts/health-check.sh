#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="${K8S_NAMESPACE:-default}"
DEPLOYMENT="${K8S_DEPLOYMENT:-calculator}"
SERVICE="${K8S_SERVICE:-calculator-service}"
SERVICE_PORT="${K8S_SERVICE_PORT:-8080}"
ATTEMPTS="${HEALTH_ATTEMPTS:-30}"
SLEEP_SECONDS="${HEALTH_SLEEP_SECONDS:-2}"

echo "Waiting for deployment rollout..."

kubectl \
  --namespace "${NAMESPACE}" \
  rollout status \
  "deployment/${DEPLOYMENT}" \
  --timeout=180s

HEALTH_PATH="/api/v1/namespaces/${NAMESPACE}/services/http:${SERVICE}:${SERVICE_PORT}/proxy/actuator/health"

echo "Checking application health..."

for attempt in $(seq 1 "${ATTEMPTS}"); do
  response="$(kubectl get --raw "${HEALTH_PATH}" 2>/dev/null || true)"

  if printf '%s' "${response}" \
    | grep -Eq '"status"[[:space:]]*:[[:space:]]*"UP"'
  then
    echo "Application health check passed:"
    echo "${response}"
    exit 0
  fi

  echo "Health attempt ${attempt}/${ATTEMPTS} failed"
  sleep "${SLEEP_SECONDS}"
done

echo "ERROR: Application did not become healthy"
exit 1
