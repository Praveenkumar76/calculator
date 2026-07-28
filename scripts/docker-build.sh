#!/bin/bash
set -e

echo "========== DOCKER BUILD START =========="

TAG=${GO_PIPELINE_COUNTER:-local}

echo "Building image: skycorex/calculator:${TAG}"

docker build \
    -t skycorex/calculator:${TAG} \
    .

echo "========== DOCKER BUILD SUCCESS =========="