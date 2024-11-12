
variable "build_project_name" {
  description = "Name of build project"
  type        = string
  default     = "jdh-testBuildProject123"
}

variable "codebuild_service_role_arn" {
  description = "The ARN of the IAM role for the CodeBuild project"
  type        = string
}


variable "codepipeline_bucket_name" {
  description = "S3 bucket name for CodePipeline artifact storage"
  type        = string
}