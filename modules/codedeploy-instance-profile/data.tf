data "aws_secretsmanager_secret" "env_secret" {
  name = var.env_secret
}

data "aws_kms_key" "kms_key" {
  key_id = "alias/${var.kms_key}"
}
