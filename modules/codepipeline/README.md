# CodePipeline

Current version: `v0.0.1`

This Terraform module creates AWS CodePipeline with three stages:
* **Source** - fetches source code from a given branch of GitHub repository
* **Build** - builds Docker image using AWS CodeBuild project
* **Deploy** - deploys app to EC2 Instance(s) using AWS CodeDeploy

CodePipeline will run each time it detects source code changes in repository branch (i.e. new commit).

*Note*. CodePipeline will run automatically after it is created.


# Usage

```terraform
data "aws_codestarconnections_connection" "github_connection" {
  name = "myproject-github"
}

locals {
  name_prefix = "myproject-staging"
}

module "myproject_staging_codepipeline" {
  source = "github.com/code87/tf-aws-devtools//modules/codepipeline?ref=v0.0.1"

  name_prefix = local.name_prefix

  # S3 Bucket (see definition below)
  s3_bucket_arn  = module.codepipeline_s3_bucket.s3_bucket_arn
  s3_bucket_name = module.codepipeline_s3_bucket.s3_bucket_name

  # Source stage
  github_connection_arn = data.aws_codestarconnections_connection.github_connection.arn
  github_repo           = "username/my-repo"
  github_repo_branch    = "main"

  # Build stage (see CodeBuild Project definition below)
  codebuild_project_name = module.codebuild.project_name

  # Deploy stage (see CodeDeploy resources definition below)
  codedeploy_app_name              = module.codedeploy.app_name
  codedeploy_deployment_group_name = module.codedeploy.deployment_group_name
}

module "codepipeline_s3_bucket" {
  source = "github.com/code87/tf-aws-devtools//modules/codepipeline-s3-bucket?ref=v0.0.1"

  name_prefix = local.name_prefix
}

module "codebuild" {
  source = "github.com/code87/tf-aws-devtools//modules/codebuild?ref=v0.0.1"

  name_prefix     = local.name_prefix
  s3_bucket_arn   = module.codepipeline_s3_bucket.s3_bucket_arn
  kms_key         = "myproject-staging-key"
  # ...
}

module "codedeploy" {
  source = "github.com/code87/tf-aws-devtools//modules/codedeploy?ref=v0.0.1"

  name_prefix              = local.name_prefix
  ec2_instance_name_filter = "myproject-staging-server"
  # ...
}
```


# Requirements

| Name        | Version           |
|-------------|-------------------|
| `terraform` | >= 1.0.0, < 2.0.0 |
| `aws`       | ~> 4.0            |


# Resources

| Name                       | Type                    |
|----------------------------|-------------------------|
| `codepipeline`             | `aws_codepipeline`      |
| `codepipeline_role`        | `aws_iam_role`          |
| `codepipeline_role_policy` | `aws_iam_role_policy`   |


# Inputs

* `name_prefix` (required, `string`) - prefix to prepend resource names.<br/>
  Example: `myproject-staging`

* `s3_bucket_name` (required, `string`) - name of the S3 Bucket for a CodePipeline.

* `s3_bucket_arn` (required, `string`) - ARN of the S3 Bucket for a CodePipeline.

* `github_connection_arn` (required, `string`) - ARN of the AWS CodeStar connection to GitHub.

* `github_repo` (required, `string`) - path to GitHub repository.<br/>
  Example: `username/my-repo`

* `github_repo_branch` (required, `string`) - name of the target repository branch.</br>
  Example: `main`

* `codebuild_project_name` (required, `string`) - name of the AWS CodeBuild project resource.

* `codedeploy_app_name` (required, `string`) - name of the AWS CodeDeploy Application resource.

* `codedeploy_deployment_group_name` (required, `string`) - name of the AWS CodeDeploy Deployment Group resource.


# Outputs

* `codepipeline_id` - the CodePipeline resource ID.
* `codepipeline_arn` - the CodePipeline resource ARN.
