# CodeBuild

Terraform module that creates AWS CodeBuild Project to work with AWS CodePipeline.


# Usage

```terraform
module "my_codebuild_project" {
  source = "github.com/code87/tf-aws-devtools//modules/codebuild?ref=v0.0.1"

  name_prefix     = "myproject-staging"
  build_timeout   = 20
  compute_type    = "BUILD_GENERAL1_MEDIUM"
  image           = "aws/codebuild/standard:5.0"
  type            = "LINUX_CONTAINER"
  privileged_mode = true
  s3_bucket_arn   = my_codepipeline_s3_bucket.arn
  kms_key         = "myproject-staging"

  build_env_vars = [
    {
      name  = "AWS_ACCOUNT_ID",
      value = data.aws_caller_identity.current.account_id,
      type  = "PLAINTEXT"
    },
    {
      name  = "AWS_REGION",
      value = data.aws_region.current.name,
      type  = "PLAINTEXT"
    },
    {
      name  = "ENV_SECRET",
      value = "myproject/staging/Env",
      type  = "PLAINTEXT"
    },
    {
      name  = "DOCKER_IMAGE_NAME",
      value = "myproject",
      type  = "PLAINTEXT"
    },
    {
      name  = "BUILD_KEY",
      value = "myproject/staging/Env:BUILD_KEY",
      type  = "SECRETS_MANAGER"
    }
  ]
}
```


# Requirements

| Name        | Version           |
|-------------|-------------------|
| `terraform` | >= 1.0.0, < 2.0.0 |
| `aws`       | ~> 4.0            |


# Resources

| Name                    | Type                    |
|-------------------------|-------------------------|
| `codebuild_project`     | `aws_codebuild_project` |
| `codebuild_role`        | `aws_iam_role`          |
| `codebuild_role_policy` | `aws_iam_role_policy`   |
| `codebuild_kms_grant`   | `aws_kms_grant`         |


# Inputs

* `name_prefix` (required, `string`) - prefix to prepend resource names.<br/>
  Example: `myproject-staging`

* `s3_bucket_arn` (required, `string`) - ARN of CodePipeline S3 Bucket that contains source code output.

* `build_timeout` (optional, `number`) - build timeout in minutes. Valid values are from 5 to 480.<br/>
  Default: `60`

* `compute_type` (optional, `string`) - information about the compute resources the build project will use. See AWS CodeBuild docs for details.<br/>
  Default: `BUILD_GENERAL1_MEDIUM`

* `image` (optional, `string`) - Docker image to use for this build project. See AWS CodeBuild docs for details.<br/>
  Default: `aws/codebuild/standard:5.0`

* `type` (optional, `string`) - type of build environment to use for related builds. See AWS CodeBuild docs for details.<br/>
  Default: `LINUX_CONTAINER`

* `privileged_mode` (optional, `bool`) - indicates whether to enable running the Docker daemon inside a Docker container.<br/>
  Default: `false`

* `build_env_vars` (optional, `list(object({name = string, value = string, type = string}))`) - list of environment variables to pass to build project.
  _See usage example above_.<br/>
  Default: `[]`

* `kms_key` (required, `string`) - alias for KMS custom-managed key that is used for environment secret encryption.<br/>
  Example: `myproject-staging`


# Outputs

*  `project_name` - name of created CodeBuild project


# TODO

* make `PLAINTEXT` default `type` of `build_env_vars` object, improve variable documentation
* better document `compute_type`, `image` and `type` variables
