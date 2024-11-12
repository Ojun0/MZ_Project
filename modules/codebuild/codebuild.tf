# CodeBuild Project
resource "aws_codebuild_project" "build_project" {
  name          = var.build_project_name
  service_role  = var.codebuild_service_role_arn

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:5.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true
  }

  cache {
    type     = "S3"
    location = var.codepipeline_bucket_name 
  }
}
