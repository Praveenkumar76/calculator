#!/bin/bash
set -e

echo "========== BUILD START =========="

mvn clean verify

echo "========== BUILD SUCCESS =========="
echo "DONE"