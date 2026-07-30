#!/usr/bin/env bash

set -euo pipefail

SONAR_HOST_URL="http://host.docker.internal:9000"
SONAR_TOKEN="PASTE_YOUR_CURRENT_SONAR_TOKEN_HERE"

PROJECT_KEY="calculator"
JACOCO_REPORT="target/site/jacoco/jacoco.xml"

echo "========================================"
echo "Running main-branch SonarQube analysis"
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
    -Dsonar.projectName="Calculator" \
    -Dsonar.host.url="${SONAR_HOST_URL}" \
    -Dsonar.token="${SONAR_TOKEN}" \
    -Dsonar.coverage.jacoco.xmlReportPaths="${JACOCO_REPORT}" \
    -Dsonar.qualitygate.wait=true \
    -Dsonar.qualitygate.timeout=300

echo "Main branch passed the SonarQube Quality Gate."
