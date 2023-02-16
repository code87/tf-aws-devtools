resource "aws_s3_bucket" "codepipeline_s3_bucket" {
  bucket        = "${var.name_prefix}-codepipeline-s3-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "codepipeline_s3_bucket_acl" {
  bucket = aws_s3_bucket.codepipeline_s3_bucket.id
  acl    = "private"
}
