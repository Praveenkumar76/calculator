#!/usr/bin/env bash

set -euo pipefail

SONAR_HOST_URL="http://host.docker.internal:9000"
SONAR_TOKEN="squ_c1a768b8f81019da9083bc90047752c617defe94"

: "${GO_SCM_CALCULATOR_PR_PR_ID:?PR ID is unavailable}"

PR_ID="${GO_SCM_CALCULATOR_PR_PR_ID}"
PROJECT_KEY="calculator-pr-${PR_ID}"
JACOCO_REPORT="target/site/jacoco/jacoco.xml"

echo "========================================"
echo "Running local SonarQube analysis"
echo "PR number: ${PR_ID}"
echo "Project key: ${PROJECT_KEY}"
echo "========================================"

if [[ ! -f "${JACOCO_REPORT}" ]]; then
    echo "ERROR: JaCoCo XML report not found:"
    echo "${JACOCO_REPORT}"
    exit 1
fi

mvn \
    --batch-mode \
    --no-transfer-progress \
    sonar:sonar \
    -Dsonar.projectKey="${PROJECT_KEY}" \
    -Dsonar.projectName="Calculator PR ${PR_ID}" \
    -Dsonar.host.url="${SONAR_HOST_URL}" \
    -Dsonar.login="${SONAR_TOKEN}" \
    -Dsonar.coverage.jacoco.xmlReportPaths="${JACOCO_REPORT}" \
    -Dsonar.qualitygate.wait=true \
    -Dsonar.qualitygate.timeout=300

echo "PR ${PR_ID} passed the SonarQube Quality Gate."
