#!/usr/bin/env bash

set -Eeuo pipefail

echo "Verifying Docker..."

docker --version
docker compose version

systemctl is-active docker >/dev/null

echo "✓ Docker running"
echo "✓ Docker Compose available"

echo
echo "Docker verification passed."
