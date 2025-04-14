#!/bin/bash

# Installs Go Workflow Yourself (GWY) workflows
# and actions into client application repository.

set -e  # Exit on any error

# Check if we're in a Git repository root
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Error: Not inside a Git repository. Please run this script from your repo's root."
  exit 1
fi

# Temporary directory for cloning
BRANCH="master"
TMP_DIR="/tmp/ci-tmp"
REPO_URL="https://github.com/earcamone/gwy.git"

# Clean up temporary directory on exit (success or failure)
cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT

# Clone the GWY repo (shallow, no checkout, specific branch)
git clone --no-checkout --depth=1 --branch "$BRANCH" "$REPO_URL" "$TMP_DIR"

# Move to temp directory
cd "$TMP_DIR"

# Set up sparse checkout for workflows and actions
git sparse-checkout set .github/workflows .github/actions

# Checkout the branch
git checkout "$BRANCH"

# Return to original directory
cd -

# Create .github directory if it doesn't exist
mkdir -p .github

# Copy workflows
cp -r "$TMP_DIR/.github/workflows" .github/

# Copy actions (ignore if directory doesn't exist)
cp -r "$TMP_DIR/.github/actions" .github/ 2>/dev/null || true

echo "GWY successfully installed, now you can Go Workflow Yourself!"