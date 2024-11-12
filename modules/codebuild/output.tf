output "codebuild_project_name" {
  value       = aws_codebuild_project.build_project.name
  description = "The name of the CodeBuild project"
}
