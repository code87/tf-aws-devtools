# CodeDeploy Instance Profile

Terraform module that creates IAM Instance Profile for EC2 Instances which allows AWS CodeDeploy
to deploy apps to those instances.


# Usage

```terraform
module "my_code_deploy_instance_profile" {
  source = "github.com/code87/tf-aws-devtools//modules/code-deploy-instance-profile?ref=v0.0.1"

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
| `code_deploy_instance_profile`        | `aws_iam_instance_profile`       |
| `code_deploy_instance_role`           | `aws_iam_role`                   |
| `code_deploy_kms_grant`               | `aws_kms_grant`                  |
| `code_deploy_instance_role_policy`    | `aws_iam_role_policy`            |
| `AmazonSSMManagedInstanceCore`        | `aws_iam_role_policy_attachment` |
| `AmazonEC2ContainerRegistryPowerUser` | `aws_iam_role_policy_attachment` |


# Inputs

| Name          | Description                                                                                                                       | Type     | Default | Required |
|---------------|-----------------------------------------------------------------------------------------------------------------------------------|----------|---------|----------|
| `name_prefix` | Prefix to prepend resource names. Example: `myproject-staging`                                                                    | `string` |         | yes      |
| `env_secret`  | Name of AWS Secrets Manager secret that contains environment variables for app build and deploy. Example: `myproject/staging/Env` | `string` |         | yes      |
| `kms_key`     | Alias for KMS custom-managed key that is used for environment secret encryption. Example: `myproject-staging`                     | `string` |         | yes      |


# Outputs

| Name                    | Description                       |
|-------------------------|-----------------------------------|
| `instance_profile_name` | Created IAM Instance Profile name |
