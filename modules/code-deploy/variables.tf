variable "name_prefix" {
  description = "Prefix to prepend resource names. Example: myproject-staging"
  type        = string
}

variable "deployment_config" {
  description = "A set of rules and success and failure conditions used by CodeDeploy during a deployment. Values: CodeDeployDefault.AllAtOnce (default), CodeDeployDefault.HalfAtATime, CodeDeployDefault.OneAtATime"
  type        = string
  default     = "CodeDeployDefault.AllAtOnce"
}

variable "deployment_type" {
  description = "Indicates whether to run an in-place deployment or a blue/green deployment. Values: IN_PLACE (default), BLUE_GREEN"
  type        = string
  default     = "IN_PLACE"
}

variable "ec2_instance_name_filter" {
  description = "A filter to determine the names of EC2 Instances to deploy to. Example: myproject-staging"
  type        = string
}
