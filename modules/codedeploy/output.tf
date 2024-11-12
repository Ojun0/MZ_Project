output "codedeploy_app_name" {
  value       = aws_codedeploy_app.app.name
  description = "The name of the CodeDeploy app"
}

output "deployment_group_name" {
  description = "The name of the CodeDeploy deployment group"
  value       = aws_codedeploy_deployment_group.deployment_group.deployment_group_name
}