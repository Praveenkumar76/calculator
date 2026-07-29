#!/usr/bin/env bash

set -euo pipefail

echo "========================================"
echo "Running pull-request quality validation"
echo "========================================"

echo
echo "Java version:"
java -version

echo
echo "Maven version:"
mvn -version

echo
echo "Running tests and quality gates:"
echo "  - Unit and integration tests"
echo "  - PMD static analysis"
echo "  - SpotBugs analysis"
echo "  - JaCoCo 80% line-coverage check"
echo

mvn \
  --batch-mode \
  --no-transfer-progress \
  clean verify

echo
echo "========================================"
echo "Pull-request validation completed"
echo "========================================"
