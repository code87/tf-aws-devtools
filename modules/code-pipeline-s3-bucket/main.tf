resource "aws_s3_bucket" "code_pipeline_s3_bucket" {
  bucket        = "${var.name_prefix}-code-pipeline-s3-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "code_pipeline_s3_bucket_acl" {
  bucket = aws_s3_bucket.code_pipeline_s3_bucket.id
  acl    = "private"
}
