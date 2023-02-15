output "s3_bucket_arn" {
  value = aws_s3_bucket.code_pipeline_s3_bucket.arn
}

output "s3_bucket_name" {
  value = aws_s3_bucket.code_pipeline_s3_bucket.bucket
}
