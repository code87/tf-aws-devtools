# CodeDeploy

Current version: `v0.0.1`

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

* `name_prefix` (required, `string`) - prefix to prepend resource names.<br/>
  Example: `myproject-staging`

* `deployment_config` (optional, `string`) - a set of rules and success and failure conditions used by CodeDeploy during a deployment. Values:
  * `CodeDeployDefault.AllAtOnce` (default)
  * `CodeDeployDefault.HalfAtATime`
  * `CodeDeployDefault.OneAtATime`

* `deployment_type` (optional, `string`) - indicates whether to run an in-place deployment or a blue/green deployment.
  Values: `IN_PLACE` (default), `BLUE_GREEN`.

* `ec2_instance_name_filter` (required, `string`) - a filter to determine the names of EC2 Instances to deploy to.<br/>
  Example: `myproject-staging`


# Outputs

* `app_name` - CodeDeploy application name

* `deployment_group_name` - CodeDeploy deployment group name
