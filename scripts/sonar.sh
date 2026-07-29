#!/bin/bash
set -e

echo "========== SONAR START =========="

mvn clean verify sonar:sonar \
  -Dsonar.projectKey=calculator \
  -Dsonar.host.url=http://host.docker.internal:9000 \
  -Dsonar.login=squ_d97765630e79de0839c01c47ed64ed933fa45d33 \
  -Dsonar.coverage.jacoco.xmlReportPaths=target/site/jacoco/jacoco.xml \
  -Dsonar.qualitygate.wait=true

echo "========== SONAR SUCCESS =========="