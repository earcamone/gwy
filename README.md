
# Go Workflow Yourself (GWY)

![GWY Nerdy Gopher](https://github.com/earcamone/gwy/blob/gh-pages/images/candidate/gopher.jpg)

## Summary

Wouldn't it be cool to have a full-featured, reusable among teams and easy to configure CI Pipeline that you 
could just clone into your Go applications repositories with a one-liner, and you are done? And what if it 
could not only guarantee the integrity of your code base, but could also allow you to -from within your repo 
actions section- perform releasing of versions, blue / green deployments, down/up scaling, etc..

So that is, at its core, the simple idea behind GWY.
<br><br>

## Features

Go Workflow Yourself delivers a full-featured GitHub  
Actions CI Pipeline that performs the following actions:  

  - unit tests and coverage threshold enforcement
  - hardcoded secrets scan
  - vulnerabilities scan
  - outdated dependencies scan
  - gofmt scan
  - linting scan

Additionally, it also aims at allowing you to control from within your GitHub Actions section your entire development 
cycle till production deployment and maintenance (up/down scaling of instances, architecture provisioning, blue/green 
deployments, etc.), though many of these features will be added in the near future, bare with me for now with current
available features :)

Right now you are able to only release your application versions to AWS ECR. Blue / green deployments and architecture 
provisioning will be leveraged by other open-source project I have once it gets integrated to GWY called [Go Terraform 
Yourself (GTY)](https://github.com/earcamone/gty.git).
<br><br>
  
## Installation

Just go to the application repo's root where you want to integrate GWY and run:

```sh
git rev-parse --is-inside-work-tree >/dev/null 2>&1 && 
git clone --no-checkout --depth=1 --branch master https://github.com/earcamone/gwy.git /tmp/ci-tmp && 
cd /tmp/ci-tmp && git sparse-checkout set .github/workflows .github/actions && git checkout master && 
cd - && mkdir -p .github && cp -r /tmp/ci-tmp/.github/workflows .github/ && 
(cp -r /tmp/ci-tmp/.github/actions .github/ || true) && rm -rf /tmp/ci-tmp || 
echo "Error: failed to set up Go Terraform Yourself (GWY). Did you run the install one-liner from within your repo's root?)"
```

The installation "one-liner" will integrate the latest GWY workflows into your repo's `.github` directory. All GWY 
files start with "gwy-" just in case you have your own workflows, to prevent conflicts during this process.

**NOTE:** 

GitHub Actions have some twerks. For example, when pushing workflows to a feature branch, it will show up in the repo's 
Actions tab, but there’s a catch: it won’t be fully functional, manual runs using the "Run workflow" button won't 
appear until it’s merged to the default branch or have been previously run, which, if you can't see the button to run 
them, as you might already imagine, might be difficult. 

Thus, you have two options to accomplish this. If your environment allows you to, you can change the repo's default 
branch for a while to test GWY manually, or you can merge GWY files to your repo's default branch.
<br><br>

## Configuration

There is a lot of work around GWY to present cool looking reports, with artifacts evidence, etc.. and this includes, 
trying to ease the need of client to endure complex configuration processes. Though, being a CI, as you can imagine, 
there are still some mandatory configuration you will have to do, though I tried to make is as centralized and easy 
as possible.

### Mandatory Repository Token

GWY requires a [GitHub fine-grained token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-fine-grained-personal-access-token) stored in your repo with secret name "GWY_REPO_TOKEN", 
to perform automatic PRs creation with fixes, with the following permissions:

 - **Contents:** read and write
 
![GWY Actions](https://github.com/earcamone/gwy/blob/gh-pages/images/candidate/permissions-contents.jpg)
<br>

 - **Pull Requests:** read and write

![GWY Actions](https://github.com/earcamone/gwy/blob/gh-pages/images/candidate/permissions-prs.jpg)
<br>

 - **Workflows:** read and write

![GWY Actions](https://github.com/earcamone/gwy/blob/gh-pages/images/candidate/permissions-workflows.jpg)
<br>

### Optional AWS Token  

**NOTE:** You need to configure this step only if you are going use the "GWY/Release: AWS" workflow, otherwise, you can 
skip this step. The first official release will integrate GitHub IODC Provider support for AWS, removing the need to 
use AWS access keys.

You need to create in your AWS console an access key with the following permissions:

 - Describe ECR Repositories (aws ecr describe-repositories)

```
Permission: ecr:DescribeRepositories
```

 - Create ECR Repository (aws ecr create-repository)

```
Permission: ecr:CreateRepository
```

 - Get AWS Account ID (aws sts get-caller-identity)

```
Permission: sts:GetCallerIdentity
```

 - Authenticate to ECR (aws ecr get-login-password)

```
Permission: ecr:GetAuthorizationToken
```

 - Push Docker Image to ECR (docker push)

```
Permissions:

ecr:BatchCheckLayerAvailability
ecr:InitiateLayerUpload
ecr:UploadLayerPart
ecr:CompleteLayerUpload
ecr:PutImage
```

The access key must be saved as repo secret name "GWY_TOKEN_AWS", separating the 
generated access key ID and secret access key with a ":" character, for example: 

```
JDNX8XALZO2N5NA9NC3Q:JDnwiNDLx9dkd2S09dZ/d39ClwJ4MD0x9wjdOE7c
```

### Tune GWY to your personal taste

After you configure the two secrets, GWY should work out of the box, though with all options enabled which you might
want to disable some. So, in the next section, I will describe you the different available workflows and how to run
and configure them.
<br><br>

## Workflows

Once you installed successfully GWY, you should see the following workflows in your repo's "Actions" section:

![GWY Actions](https://github.com/earcamone/gwy/blob/gh-pages/images/candidate/actions.jpg)
<br>

### GWY CI Pipeline

GWY/CI is GWY main CI Pipeline, located after installation in your repo at `.github/workflows/gwy-ci.yml`, which by 
default gets triggered with each pull request creation. You can edit the events triggering it editing the `on:` section 
in it like you would do with [any other GitHub Actions workflow](https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/triggering-a-workflow#using-events-to-trigger-workflows).

To enabled or disable any of its options, you just edit the file and set the self-explaining environment vars
located at the top of the file, comment descriptions over each config variable option will guide you out:

```
name: 'GWY/CI'

env:
  # Go version the CI should use to run actions?
  # <CURRENT> defaults to branch go.mod one.
  GWY_GO_VERSION: "<CURRENT>"

  # Should the CI allow PRs merging if any
  # of the following enabled actions fail?
  GWY_ALLOW_MERGE_ON_FAILURE: false

  # Individual Steps Timeout: set the TO for
  # each individual action that might take time
  GWY_TIMEOUT: '5m'

  # Test & Coverage Scan? set true if you want
  # CI to run tests and coverage in the code
  GWY_TESTS: true

  # Test Coverage Threshold: set coverage
  # threshold to fail or not the check
  GWY_TESTS_THRESHOLD: '90'

  ...
```
<br>

You can also run manually GWY CI Pipeline over any branch using the top right corner button "Run workflows":
<br>

![GWY Actions](https://github.com/earcamone/gwy/blob/gh-pages/images/candidate/manual.jpg)
<br>

Manually running GWY CI allows you to enable or disable any of its options per run, no matter what you configured 
within the file. When running it manually, like the other GWY individual workflows, you can specify the target branch 
to which you want to apply the workflow and the Go version you want it to use when running your application checks.

Target branch `<CURRENT>` will use as target the current selected repo branch in GitHub site, you can otherwise enter 
the name of any existent branch. For Go version to run the checks, `<CURRENT>` will pick the one specified in the 
target branch `go.mod` file, or you can specify a different Go version if you happen to want to check, for example, 
the compatibility of your code with newer versions.
<br>

GWY CI Pipeline generates a detailed summary with annotations, both to notice errors or success, 
with evidence artifacts with more detailed information than the presented in the summary section:

![GWY Summary](https://github.com/earcamone/gwy/blob/gh-pages/images/candidate/summary.jpg)
<br>

![GWY Annotations](https://github.com/earcamone/gwy/blob/gh-pages/images/candidate/annotations.jpg)
<br>

![GWY Artifacts](https://github.com/earcamone/gwy/blob/gh-pages/images/candidate/artifacts.jpg)
<br>

### Version Releasing to AWS/ECR

To release application versions to AWS ECR (other platforms coming soon),
you can run the "GWY/Release: AWS" workflow from within Actions section:

![GWY Release](https://github.com/earcamone/gwy/blob/gh-pages/images/candidate/release.jpg)

You must pick the branch from which the workflow should build the application image using its `Dockerfile` that 
expects it to be in the repo's root. Workflow will attempt to upload the application to a repo with the same name 
as your application's one according to your application module name in the `go.mod` file. As version tag, it will 
attempt to extract it from the selected branch, if it follows release branches convention, otherwise it will use 
the entire branch name as version tag, assuming it's a feature branch version being tested in develop environment.

If you don't follow the standard docker images push convention of using `{registry}/{app}:{version}`, let's say you
were using, for example, a DockerHub private account and pushing different applications to the same repository and
tagging them with `{app}-{version}`, you can edit the release workflow file `.github/workflows/gwy-aws-release.yml`:

```yml
      - name: Set Release Environment Symbols
        run: |
          # release environment symbols configuration (token, repository, etc)
          GWY_RELEASE_TAG=""
          GWY_RELEASE_TOKEN=""
          GWY_RELEASE_REPOSITORY=""

          # Set symbols for environment: "production"
          if [ "${{ inputs.environment }}" = "production" ]; then
            GWY_RELEASE_REPOSITORY="$GWY_APP"
            GWY_RELEASE_TAG="$GWY_APP_VERSION"
            GWY_RELEASE_TOKEN="${{ secrets.GWY_TOKEN_AWS }}"

          # Set symbols for environment: "develop"
          elif [ "${{ inputs.environment }}" = "develop" ]; then
            GWY_RELEASE_REPOSITORY="$GWY_APP"
            GWY_RELEASE_TAG="$GWY_APP_VERSION"
            GWY_RELEASE_TOKEN="${{ secrets.GWY_TOKEN_AWS }}"

          # Set symbols for environment: "staging"
          elif [ "${{ inputs.environment }}" = "staging" ]; then
            GWY_RELEASE_REPOSITORY="$GWY_APP"
            GWY_RELEASE_TAG="$GWY_APP_VERSION"
            GWY_RELEASE_TOKEN="${{ secrets.GWY_TOKEN_AWS }}"
          fi
```

Let's say you want to change your target repository to a static name and tag images with 
`{app}-{version}`, you would then change the corresponding deployment environments like this:

```sh
          # Set symbols for environment: "production"
          if [ "${{ inputs.environment }}" = "production" ]; then
            GWY_RELEASE_REPOSITORY="static-repo-name"
            GWY_RELEASE_TAG="$GWY_APP-$GWY_APP_VERSION"
            GWY_RELEASE_TOKEN="${{ secrets.GWY_TOKEN_AWS }}"
```

In the near future, the release [workflow will include an option](https://github.com/earcamone/gwy/issues/8) which will allow you to pick the naming 
convention to follow when pushing your releases between "single-app repo" or "multi-app repo" conventions.

If you want to add new deployment environment, you simply add a new `elif` block with its corresponding repository
name and images tag logic, usually you would only change the repository name. For example, you might have a repo
name for you app releases for production and another for develop environment, and you would leave the release tag 
logic intact, releasing them to either environment with the branch release version as tag parsed by GWY:

```sh
          # Set symbols for environment: "production"
          if [ "${{ inputs.environment }}" = "production" ]; then
            GWY_RELEASE_REPOSITORY="$GWY_APP-prod"
            GWY_RELEASE_TAG="$GWY_APP_VERSION"
            GWY_RELEASE_TOKEN="${{ secrets.GWY_TOKEN_AWS }}"

          # Set symbols for environment: "develop"
          elif [ "${{ inputs.environment }}" = "develop" ]; then
            GWY_RELEASE_REPOSITORY="$GWY_APP-develop"
            GWY_RELEASE_TAG="$GWY_APP_VERSION"
            GWY_RELEASE_TOKEN="${{ secrets.GWY_TOKEN_AWS }}"
```

Don't forget, if you add a new environment, to add the option at the top of the file as option:

```yml
      environment:
        description: 'Environment'
        required: true
        default: 'develop'

        type: choice
        options:
          - develop
          - staging
          - production
```
