output "app_name" {
  value = aws_codedeploy_app.codedeploy_app.name
}

output "deployment_group_name" {
  value = aws_codedeploy_deployment_group.codedeploy_deployment_group.deployment_group_name
}
