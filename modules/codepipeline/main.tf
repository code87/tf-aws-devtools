resource "aws_codepipeline" "codepipeline" {
  name     = "${var.name_prefix}-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = var.s3_bucket_name
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = var.github_connection_arn
        FullRepositoryId = var.github_repo
        BranchName       = var.github_repo_branch
        DetectChanges    = true
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = var.codebuild_project_name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        ApplicationName     = var.codedeploy_app_name
        DeploymentGroupName = var.codedeploy_deployment_group_name
      }
    }
  }
}

resource "aws_iam_role" "codepipeline_role" {
  name = "${var.name_prefix}-codepipeline-role"

  assume_role_policy = <<EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Service": "codepipeline.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
  EOF
}

resource "aws_iam_role_policy" "codepipeline_role_policy" {
  name = "${var.name_prefix}-codepipeline-policy"
  role = aws_iam_role.codepipeline_role.id

  policy = <<-POLICY
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect":"Allow",
          "Action": [
            "s3:GetObject",
            "s3:GetObjectVersion",
            "s3:GetBucketVersioning",
            "s3:PutObjectAcl",
            "s3:PutObject"
          ],
          "Resource": [
            "${var.s3_bucket_arn}",
            "${var.s3_bucket_arn}/*"
          ]
        },
        {
          "Effect": "Allow",
          "Action": [
            "codestar-connections:UseConnection"
          ],
          "Resource": "${var.github_connection_arn}"
        },
        {
          "Effect": "Allow",
          "Action": [
            "codebuild:BatchGetBuilds",
            "codebuild:StartBuild"
          ],
          "Resource": "*"
        },
        {
          "Action": [
              "codedeploy:CreateDeployment",
              "codedeploy:GetApplication",
              "codedeploy:GetApplicationRevision",
              "codedeploy:GetDeployment",
              "codedeploy:GetDeploymentConfig",
              "codedeploy:RegisterApplicationRevision"
          ],
          "Resource": "*",
          "Effect": "Allow"
        }
      ]
    }
  POLICY
}
