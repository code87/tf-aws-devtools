# CodeDeploy Instance Profile

Current version: `v0.0.1`

Terraform module that creates IAM Instance Profile for EC2 Instances which allows AWS CodeDeploy
to deploy apps to those instances.


# Usage

```terraform
module "my_codedeploy_instance_profile" {
  source = "github.com/code87/tf-aws-devtools//modules/codedeploy-instance-profile?ref=v0.0.1"

  name_prefix = "myproject-staging"
  env_secret  = "myproject/staging/Env"
  kms_key     = "myproject-staging"
}
```


# Requirements

| Name        | Version           |
|-------------|-------------------|
| `terraform` | >= 1.0.0, < 2.0.0 |
| `aws`       | ~> 4.0            |


# Resources

| Name                                  | Type                             |
|---------------------------------------|----------------------------------|
| `codedeploy_instance_profile`         | `aws_iam_instance_profile`       |
| `codedeploy_instance_role`            | `aws_iam_role`                   |
| `codedeploy_kms_grant`                | `aws_kms_grant`                  |
| `codedeploy_instance_role_policy`     | `aws_iam_role_policy`            |
| `AmazonSSMManagedInstanceCore`        | `aws_iam_role_policy_attachment` |
| `AmazonEC2ContainerRegistryPowerUser` | `aws_iam_role_policy_attachment` |


# Inputs

* `name_prefix` (required, `string`) - prefix to prepend resource names.<br/>
  Example: `myproject-staging`

* `env_secret` (required, `string`) - name of AWS Secrets Manager secret that contains environment variables for app build and deploy.<br/>
  Example: `myproject/staging/Env`

* `kms_key` (required, `string`) - alias for KMS custom-managed key that is used for environment secret encryption.<br/>
  Example: `myproject-staging`


# Outputs

* `instance_profile_name` - name of created IAM Instance Profile
