# CodePipeline S3 Bucket

Terraform module that creates S3 bucket to be used by AWS CodePipeline.


# Usage

```terraform
module "my_codepipeline_s3_bucket" {
  source = "github.com/code87/tf-aws-devtools//modules/codepipeline-s3-bucket?ref=v0.0.1"

  name_prefix = "myproject-staging"
}
```


# Requirements

| Name        | Version           |
|-------------|-------------------|
| `terraform` | >= 1.0.0, < 2.0.0 |
| `aws`       | ~> 4.0            |


# Resources

| Name                         | Type                |
|------------------------------|---------------------|
| `codepipeline_s3_bucket`     | `aws_s3_bucket`     |
| `codepipeline_s3_bucket_acl` | `aws_s3_bucket_acl` |


# Inputs

* `name_prefix` (required, `string`) - prefix to prepend resource names.<br/>
  Example: `myproject-staging`


# Outputs

* `s3_bucket_arn` - ARN of created S3 Bucket

* `s3_bucket_name` - name of created S3 Bucket
