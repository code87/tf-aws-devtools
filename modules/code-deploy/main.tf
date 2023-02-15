resource "aws_codedeploy_app" "codedeploy_app" {
  name = "${var.name_prefix}-codedeploy-app"
}

resource "aws_codedeploy_deployment_group" "codedeploy_deployment_group" {
  deployment_group_name  = "${var.name_prefix}-codedeploy-deployment-group"
  app_name               = aws_codedeploy_app.codedeploy_app.name
  service_role_arn       = aws_iam_role.codedeploy_role.arn
  deployment_config_name = var.deployment_config

  auto_rollback_configuration {
    enabled = false
  }

  deployment_style {
    deployment_type = var.deployment_type
  }

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = var.ec2_instance_name_filter
    }
  }
}

resource "aws_iam_role" "codedeploy_role" {
  name = "${var.name_prefix}-codedeploy-role"

  assume_role_policy = <<-EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "",
          "Effect": "Allow",
          "Principal": {
            "Service": "codedeploy.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
  EOF
}

resource "aws_iam_role_policy_attachment" "AWSCodeDeployRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  role       = aws_iam_role.codedeploy_role.name
}
