output "github_connection_arn" {
  value       = aws_codestarconnections_connection.github_connection.arn
  description = "ARN of the GitHub connection used for CodePipeline"
}
