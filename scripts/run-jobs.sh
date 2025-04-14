#!/bin/bash

#
# Simple script to run manually at once all GWY workflows
# with different options to ensure everything works fine
#

# GWY workflow files to test location
REPO="earcamone/gapi"
BRANCH="feature/no-ref/final-modular-ci"

# GWY workflow custom options
OPTION_GO_VERSION="1.24.1"
OPTION_CUSTOM_BRANCH="feature/no-ref/final-modular-ci-dependencies-fix"

# GWY workflow files
# List of workflow files to run
WORKFLOW_FILES=(
  "gwy-ci.yml"
  "gwy-coverage.yml"
  "gwy-dependencies.yml"
  "gwy-gofmt.yml"
  "gwy-lint.yml"
  "gwy-secrets.yml"
  "gwy-vulnerabilities.yml"
)

run_workflow() {
  local workflow_file=$1
  shift
  local params="$@"

  echo "Triggering workflow: $workflow_file with params: $params"
  echo " - gh workflow run \"$workflow_file\" --repo \"$REPO\" $params"

  gh workflow run "$workflow_file" --repo "$REPO" --ref "$BRANCH" $params
  [ $? -eq 0 ] && echo "Successfully triggered $workflow_file" || { echo "Failed to trigger $workflow_file"; exit 1; }
}

# Run all workflows with default options and common custom ones
for workflow in "${WORKFLOW_FILES[@]}"; do
  run_workflow "$workflow"                                     # Default values
  run_workflow "$workflow" -f branch=invalid                   # Invalid branch
  run_workflow "$workflow" -f branch="$OPTION_CUSTOM_BRANCH"   # Custom branch
  run_workflow "$workflow" -f go-version="$OPTION_GO_VERSION"  # Custom Go version
done

# Run badges generation workflow
run_workflow "gwy-badges.yml"
run_workflow "gwy-badges.yml" -f branch=invalid
run_workflow "gwy-badges.yml" -f badges-branch="<NONE>"
run_workflow "gwy-badges.yml" -f badges-branch="<GH-PAGES>"
run_workflow "gwy-badges.yml" -f branch="$OPTION_CUSTOM_BRANCH" -f badges-branch="custom" -f badges-directory="custom/branch/github" -f badges-url="github.com"
run_workflow "gwy-badges.yml" -f branch="$OPTION_CUSTOM_BRANCH" -f badges-branch="custom" -f badges-directory="custom/branch/githubusercontent" -f badges-url="githubusercontent.com"

# Run release workflow with custom branch
run_workflow "gwy-aws-release.yml"
run_workflow "gwy-aws-release.yml" -f "branch=$OPTION_CUSTOM_BRANCH"
