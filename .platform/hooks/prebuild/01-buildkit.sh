#!/usr/bin/env bash
set -euo pipefail
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1
docker pull node:lts-alpine || true
docker pull nginx:alpine || true
