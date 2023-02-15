variable "name_prefix" {
  description = "Prefix to prepend resource names. Example: myproject-staging"
  type        = string
}

variable "env_secret" {
  description = "Name of AWS Secrets Manager secret that contains environment variables for app build and deploy. Example: myproject/staging/Env"
  type        = string
}

variable "kms_key" {
  description = "Alias for KMS custom-managed key that is used for environment secret encryption. Example: myproject-staging"
  type        = string
}
