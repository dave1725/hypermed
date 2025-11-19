#!/bin/bash
set -euo pipefail

# Ensure globs that don't match expand to nothing (avoid chmod errors)
shopt -s nullglob

echo "installing packages and modules..."
sudo apt-get update -y

# Make local scripts executable if present
[ -d "./scripts" ] && chmod +x ./scripts/*.sh || true
[ -d "./organizations" ] && chmod +x ./organizations/*.sh || true
[ -d ".." ] && chmod +x ../*.sh || true
[ -d "../bin" ] && chmod +x ../bin/* || true
chmod +x ./*.sh || true

# Base tooling
sudo apt-get install -y git curl
sudo apt-get install -y nodejs npm || true

# Docker Engine + Compose v2 plugin (prefer docker.io on Debian/Ubuntu)
if ! command -v docker >/dev/null 2>&1; then
    echo "Installing Docker Engine..."
    sudo apt-get install -y docker.io docker-compose-plugin || true
fi

# Real jq (avoid npm 'jq' shim). Ensure /usr/bin precedes /usr/local/bin
sudo apt-get install -y jq
export PATH="/usr/bin:$PATH"

# Go toolchain (fallback to distro package)
sudo apt-get install -y golang || true

echo "setup done"
echo "starting docker (if available)"
sudo systemctl start docker 2>/dev/null || sudo service docker start 2>/dev/null || true

if [ -d "../bin" ]; then
    echo "binaries installed";
fi

if [ ! -d "../bin" ]; then
    echo "installing binaries...";
        if [ -x "../install-fabric.sh" ]; then
            ../install-fabric.sh binaries
        else
            echo "Warning: ../install-fabric.sh not found or not executable" >&2
        fi
        sudo chown -R "$(id -un)":"$(id -gn)" . || true
        [ -d "./bin" ] && mv ./bin ../ || true
        [ -d "./builders" ] && mv ./builders ../ || true
fi

# Export Fabric env before running network
export PATH="${PWD}/../bin:$PATH"
export FABRIC_CFG_PATH="${PWD}/../config"

# Prefer to run as the current user (not root); assumes user is in docker group
./network.sh up

# Ensure ownership for generated org artifacts
sudo chown -R "$(id -un)":"$(id -gn)" ./organizations || true

# Load Fabric helper env and set org context
if [ -f "./scripts/envVar.sh" ]; then
    # shellcheck disable=SC1091
    source ./scripts/envVar.sh
    setGlobals 1
else
    echo "Warning: ./scripts/envVar.sh not found; skipping Fabric env setup" >&2
fi