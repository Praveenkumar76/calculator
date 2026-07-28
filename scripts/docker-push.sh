#!/bin/bash
set -e

echo "========== DOCKER PUSH START =========="

TAG=${GO_PIPELINE_COUNTER:-local}

echo "Pushing image: skycorex/calculator:${TAG}"

docker push skycorex/calculator:${TAG}

echo "========== DOCKER PUSH SUCCESS =========="