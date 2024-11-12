variable "codepipeline_name" {
  description = "The name of the CodePipeline"
  type        = string
  default     = "tf-test-pipeline"
}

variable "codepipeline_role_arn" {
  description = "codepipeline role arn"
  type        = string
}


variable "codepipeline_bucket_name" {
  description = "codepipeline bucket name"
  type        = string
}
##### Source stage

variable "source_action_name" {
  description = "The name of the source stage"
  type        = string
  default     = "Source"
}

variable "codestar_github_connection_arn" {
  description = "codestar github connection arn"
  type        = string
}

variable "github_repository_full_id" {
  description = "The full GitHub repository ID in the format 'owner/repository'"
  type        = string
  default     = "mgzteam4/test1"
}


variable "github_branch_name" {
  description = "The branch name in the GitHub repository"
  type        = string
  default     = "main"
}

##### Build stage

variable "build_action_name" {
  description = "The name of the build stage"
  type        = string
  default     = "Build"
}

variable "codebuild_project_name" {
  description = "codebuild project name"
  type        = string
}


##### Deploy stage

variable "deploy_action_name" {
  description = "The name of the deploy stage"
  type        = string
  default     = "Deploy"
}

variable "codedeploy_app_name" {
  description = "codebuild app name"
  type        = string
}

variable "deployment_group_name" {
  description = "codebuild group name"
  type        = string
}


#### IAM
variable "codepipeline_role_id" {
  description = "codepipeline role id"
  type        = string
}

variable "codepipeline_bucket_arn" {
  description = "codepipeline bucket arn"
  type        = string
}

variable "github_connection_arn" {
  description = "github connection arn"
  type        = string
}

#Attach Policy
variable "ec2_codedeploy_role_name" {
  description = "ec2 codedeploy role name"
  type        = string
}

variable "ec2_s3_access_policy_arn" {
  description = "ec2 s3 access policy arn"
  type        = string
}