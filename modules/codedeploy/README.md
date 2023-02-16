# CodeDeploy

Terraform module that creates AWS CodeDeploy resources to be used by AWS CodePipeline:
* CodeDeploy application
* CodeDeploy deployment group

This module only supports EC2 deployments (ECS is not supported _yet_).


# Usage

```terraform
module "my_codedeploy" {
  source = "github.com/code87/tf-aws-devtools//modules/codedeploy?ref=v0.0.1"

  name_prefix              = "myproject-staging"
  deployment_config        = "CodeDeployDefault.AllAtOnce"
  deployment_type          = "IN_PLACE"
  ec2_instance_name_filter = "myproject-staging"
}
```


# Requirements

| Name        | Version           |
|-------------|-------------------|
| `terraform` | >= 1.0.0, < 2.0.0 |
| `aws`       | ~> 4.0            |


# Resources

| Name                          | Type                              |
|-------------------------------|-----------------------------------|
| `codedeploy_app`              | `aws_codedeploy_app`              |
| `codedeploy_deployment_group` | `aws_codedeploy_deployment_group` |
| `codedeploy_role`             | `aws_iam_role`                    |
| `AWSCodeDeployRole`           | `aws_iam_role_policy_attachment`  |


# Inputs

| Name                       | Description                                                    | Type     | Default | Required |
|----------------------------|----------------------------------------------------------------|----------|---------|----------|
| `name_prefix`              | Prefix to prepend resource names. Example: `myproject-staging` | `string` |         | yes      |
| `deployment_config`        | A set of rules and success and failure conditions used by CodeDeploy during a deployment. Values: `CodeDeployDefault.AllAtOnce`, `CodeDeployDefault.HalfAtATime`, `CodeDeployDefault.OneAtATime` | `string` | `CodeDeployDefault.AllAtOnce` | no      |
| `deployment_type`          | Indicates whether to run an in-place deployment or a blue/green deployment. Values: `IN_PLACE`, `BLUE_GREEN` | `string` | `IN_PLACE`        | no      |
| `ec2_instance_name_filter` | A filter to determine the names of EC2 Instances to deploy to. Example: `myproject-staging` | `string` |         | yes      |


# Outputs

| Name                    | Description                      |
|-------------------------|----------------------------------|
| `app_name`              | CodeDeploy application name      |
| `deployment_group_name` | CodeDeploy deployment group name |
