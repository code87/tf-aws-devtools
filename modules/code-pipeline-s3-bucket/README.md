# CodePipeline S3 Bucket

Terraform module that creates S3 bucket to be used by AWS CodePipeline.


# Usage

```terraform
module "my_code_pipeline_s3_bucket" {
  source = "github.com/code87/tf-aws-devtools//modules/code-pipeline-s3-bucket?ref=v0.0.1"

  name_prefix = "myproject-staging"
}
```


# Requirements

| Name        | Version           |
|-------------|-------------------|
| `terraform` | >= 1.0.0, < 2.0.0 |
| `aws`       | ~> 4.0            |


# Resources

| Name                          | Type                |
|-------------------------------|---------------------|
| `code_pipeline_s3_bucket`     | `aws_s3_bucket`     |
| `code_pipeline_s3_bucket_acl` | `aws_s3_bucket_acl` |


# Inputs

| Name          | Description                                                    | Type     | Default | Required |
|---------------|----------------------------------------------------------------|----------|---------|----------|
| `name_prefix` | Prefix to prepend resource names. Example: `myproject-staging` | `string` |         | yes      |


# Outputs

| Name             | Description               |
|------------------|---------------------------|
| `s3_bucket_arn`  | ARN of created S3 Bucket  |
| `s3_bucket_name` | Name of created S3 Bucket |

