# CodeStar Connection for GitHub
resource "aws_codestarconnections_connection" "github_connection" {
  name          = var.github_connection_name
  provider_type = "GitHub"
}


