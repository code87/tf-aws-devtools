variable "name_prefix" {
  description = "Prefix to prepend resource names. Example: myproject-staging"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name of the S3 Bucket for a CodePipeline"
  type        = string
}

variable "s3_bucket_arn" {
  description = "ARN of the S3 Bucket for a CodePipeline"
  type        = string
}

variable "github_connection_arn" {
  description = "ARN of the AWS CodeStar connection to GitHub"
  type        = string
}

variable "github_repo" {
  description = "Path to GitHub repository: Example: username/my-repo"
  type        = string
}

variable "github_repo_branch" {
  description = "Name of the target repository branch. Example: main"
  type        = string
}

variable "codebuild_project_name" {
  description = "Name of the AWS CodeBuild project resource"
  type        = string
}

variable "codedeploy_app_name" {
  description = "Name of the AWS CodeDeploy Application resource"
  type        = string
}

variable "codedeploy_deployment_group_name" {
  description = "Name of the AWS CodeDeploy Deployment Group resource"
  type        = string
}
