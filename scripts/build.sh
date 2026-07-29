#!/bin/bash
set -e

echo "========== DOCKER BUILD START =========="

mvn clean package -DskipTests

docker build -t skycorex/calculator:${GO_PIPELINE_COUNTER} .

echo "========== DOCKER BUILD SUCCESS =========="