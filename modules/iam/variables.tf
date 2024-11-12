variable "ec2_codedeploy_role_name" {
  description = "ec2 codedeploy role name"
  type        = string
  default     = "jdh-ec2_codedeploy_role"
}



variable "ec2_codedeploy_policy_name" {
  description = "ec2 codedeploy policy name"
  type        = string
  default     = "jdh-EC2CodeDeployPolicy"
}




variable "ec2_codedeploy_instance_profile_name" {
  description = "ec2 codedeploy instance profile name"
  type        = string
  default     = "jdh-ec2_codedeploy_instance_profile"
}


variable "codepipeline_role_name" {
  description = "codepipeline role name"
  type        = string
  default     = "codepipeline_role"
}



variable "codebuild_role_updated_name" {
  description = "codebuild update role name"
  type        = string
  default     = "codebuild_role_updated"
}


variable "codedeploy_role_name" {
  description = "codedeploy role name"
  type        = string
  default     = "codedeploy_role"
}



variable "ec2_s3_access_policy_name" {
  description = "ec2 to s3 access policy name"
  type        = string
  default     = "jdh-EC2S3AccessPolicy"
}