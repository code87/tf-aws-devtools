variable "name_prefix" {
  description = "Prefix to prepend resource names. Example: myproject-staging"
  type        = string
}

variable "s3_bucket_arn" {
  description = "ARN of CodePipeline S3 Bucket that contains source code output"
  type        = string
}

variable "build_timeout" {
  description = "Build timeout. Valid values are from 5 to 480. Default: 60 minutes"
  type        = number
  default     = 60
}

variable "compute_type" {
  description = "Information about the compute resources the build project will use. Default: BUILD_GENERAL1_MEDIUM"
  type        = string
  default     = "BUILD_GENERAL1_MEDIUM"
}

variable "image" {
  description = "Docker image to use for this build project. Default: aws/codebuild/standard:5.0"
  type        = string
  default     = "aws/codebuild/standard:5.0"
}

variable "type" {
  description = "Type of build environment to use for related builds. Default: LINUX_CONTAINER"
  type        = string
  default     = "LINUX_CONTAINER"
}

variable "privileged_mode" {
  description = "Indicates whether to enable running the Docker daemon inside a Docker container. Default: false"
  type        = bool
  default     = false
}

variable "build_env_vars" {
  description = "List of environment variables to pass to build project"
  type = list(object({
    var_name  = string
    var_value = string
    var_type  = string
  }))
  default = []
}

variable "kms_key" {
  description = "Alias for KMS custom-managed key that is used for environment secret encryption. Example: myproject-staging"
  type        = string
}
