#!/bin/bash

set -euo pipefail

PROJECTS_DIR="$HOME/projects"
cd "$PROJECTS_DIR"

for dir in */; do
  to_be_removed="$PROJECTS_DIR/$dir"
  to_be_removed+="cdk/cdk.out"
  rm -rf "$to_be_removed" || true
done
