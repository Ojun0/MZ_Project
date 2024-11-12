

variable "code_deploy_instance_name" {
  description = "code deploy instance name"
  type        = string 
  default     = "CodeDeployInstance"
}
 

variable "code_deploy_subnet_id" {
  description = "code deploy subnet id"
  type        = string
}


variable "codedeploy_instance_profile_id" {
  description = "codedeploy instance profile id"
  type        = string
}


variable "ec2_codedeploy_sg_id" {
  description = "ec2 codedeploy sg id"
  type        = string
}