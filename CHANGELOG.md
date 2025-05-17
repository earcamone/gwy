# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0-beta.2] - XXXX-XX-XX

### Fixed

- Badges Generation Workflow: Fixed bug in "Issues" count badge,
  it was summing together opened issues and pull requests.

## [1.0.0-beta.1] - 2025-05-16

This is the first official release beta. 

The project has been [extensively tested](https://github.com/earcamone/gwy-playground/actions)
but because, at the end of the day, it's a sole programmer project, I'm leaving
some space for possible bugs reporting so, if you find some, kindly report them.

### Added

- README and MIT LICENSE
- GWY main CI Pipeline
- Releases push to AWS/ECR manual workflow
- Documentation badges auto-generation workflow
- Code vulnerabilities scan manual workflow
- Code outdated dependencies scan manual workflow
- Code secrets (gitleaks) scan manual workflow
- Code format (gofmt) scan manual workflow
- Code linting scan (golangci-lint) scan manual workflow
- Code tests & coverage manual workflow
