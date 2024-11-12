variable "codepipeline_bucket_name" {
  description = "Bucket for CICD pipeline artifacts"
  type        = string
  default     = "jdh-cicd-pipeline-artifacts-bucket"
}

variable "codepipeline_bucket_versioning_status" {
  description = "Set codepipeline bucket versioning status"
  type        = string
  default     = "Enabled"
}

