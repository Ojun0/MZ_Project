####
## VPC
####
variable "jdh_aws_VPC_cidr_block" {
  description = "CIDR block for the jdh-aws-VPC"
  type        = string
  default     = "10.0.0.0/16"
}

####
## 보안 그룹 생성 (SSH 및 HTTP 허용)
####
variable "jdh_public_subnet_cidr_block" {
  description = "CIDR block for the jdh_public_subnet_cidr_block"
  type        = string 
  default     = "10.0.1.0/24" 
}


variable "jdh_public_subnet_availability_zone" {
  description = "Availability zone for the public subnet."
  type        = string 
  default     = "ap-northeast-2a"
}

 
variable "jdh_public_rt_cidr_block" {
  description = "Public routing table CIDR block for the public subnet."
  type        = string
  default     = "0.0.0.0/0"
}


variable "aws_private_subnets_a" {
    default = [ "10.0.3.0/24", "10.0.5.0/24","10.0.7.0/24"]
}

variable "aws_private_subnets_c" {
    default = [ "10.0.4.0/24", "10.0.6.0/24", "10.0.8.0/24" ]
}

variable "aws_private_subnets_name_a" {
    default = [ "pp-aws-a-WEB-subnet", "pp-aws-a-WAS-subnet", "pp-aws-a-DB-subnet"]
}

variable "aws_private_subnets_name_c" {
    default = [  "pp-aws-c-WEB-subnet","pp-aws-c-WAS-subnet", "pp-aws-c-DB-subnet"]
}

variable "name" {
  type    = string
  default = "pp-aws"
}

variable "ojy_bastion_sg" {
  type = string
}