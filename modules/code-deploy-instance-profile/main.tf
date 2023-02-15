resource "aws_iam_instance_profile" "code_deploy_instance_profile" {
  name = "${var.name_prefix}-code-deploy-instance-profile"
  role = aws_iam_role.code_deploy_instance_role.name
}

resource "aws_iam_role" "code_deploy_instance_role" {
  name = "${var.name_prefix}-code-deploy-instance-role"

  assume_role_policy = <<-EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "",
          "Effect": "Allow",
          "Principal": {
            "Service": "ec2.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
  EOF
}

resource "aws_kms_grant" "code_deploy_kms_grant" {
  key_id            = data.aws_kms_key.kms_key.id
  grantee_principal = aws_iam_role.code_deploy_instance_role.arn
  operations        = ["Decrypt", "DescribeKey"]
}

resource "aws_iam_role_policy" "code_deploy_instance_role_policy" {
  role = aws_iam_role.code_deploy_instance_role.id

  policy = <<-POLICY
    {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Action": [
                  "s3:Get*",
                  "s3:List*"
              ],
              "Effect": "Allow",
              "Resource": "*"
          },
          {
            "Effect": "Allow",
            "Action": [
                "secretsmanager:GetResourcePolicy",
                "secretsmanager:GetSecretValue",
                "secretsmanager:DescribeSecret",
                "secretsmanager:ListSecretVersionIds"
            ],
            "Resource": "${data.aws_secretsmanager_secret.env_secret.arn}"
        },
        {
          "Effect": "Allow",
          "Action": [
            "kms:Decrypt",
            "kms:DescribeKey"
          ],
          "Resource": "*"
        }
      ]
    }
  POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.code_deploy_instance_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryPowerUser" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
  role       = aws_iam_role.code_deploy_instance_role.name
}
