# AWS 프로바이더 설정
provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
  ojy_bastion_sg = module.security.ojy_bastoin_sg
}

module "iam" {
  source = "./modules/iam"
}

module "ecr" {
  source = "./modules/ecr"
}

module "s3" {
  source = "./modules/s3"
}

module "codestar" {
  source = "./modules/codestar"
}

module "ecs" {
  source = "./modules/ecs"
}

module "security" {
  source = "./modules/security"
  jdh_aws_VPC = module.vpc.jdh_aws_VPC
  ojy_WEB_ALB_sg = module.security.ojy_WEB_ALB_sg
  ojy_WAS_ALB_sg = module.security.ojy_WAS_ALB_sg
  ojy_WEB_sg = module.security.ojy_WEB_sg
  ojy_WAS_sg = module.security.ojy_WAS_sg
}

module "loadbalancer" {
  source = "./modules/loadbalancer"
  ojy_public_subnet_a_id = module.vpc.ojy_public_subnet_a_id
  ojy_public_subnet_c_id = module.vpc.ojy_public_subnet_c_id
  jdh_aws_VPC = module.vpc.jdh_aws_VPC
  ojy_WEB_ALB_sg = module.security.ojy_WEB_ALB_sg
  staging        = module.loadbalancer.staging
  cert           = module.acm.cert
}

#module "acm" {
#  source = "./modules/acm"
#}

#module "route53" {
#  source = "./modules/route53"
#  ojy_WEB_bucket_host_zone = module.s3.ojy_WEB_bucket_host_zone
#  ojy_WEB_bucket_name = module.s3.ojy_WEB_bucket_name
#}

module "codebuild" {
  source = "./modules/codebuild"
  codebuild_service_role_arn  = module.iam.codebuild_role_updated_arn
  codepipeline_bucket_name = module.s3.codepipeline_bucket_name
}

module "codedeploy" {
  source = "./modules/codedeploy"
  codedeploy_role_arn = module.iam.codedeploy_role_arn
}

module "ec2" {
  source = "./modules/ec2"
  code_deploy_subnet_id = module.vpc.ojy_public_subnet_a_id
  codedeploy_instance_profile_id = module.iam.ec2_codedeploy_instance_profile_id
  ec2_codedeploy_sg_id = module.security.jdh_codedeploy_sg
}

module "codepipeline" {
  source = "./modules/codepipeline"
  codepipeline_role_arn = module.iam.codepipeline_role_arn
  codepipeline_bucket_name = module.s3.codepipeline_bucket_name
  codestar_github_connection_arn = module.codestar.github_connection_arn
  codebuild_project_name = module.codebuild.codebuild_project_name
  codedeploy_app_name = module.codedeploy.codedeploy_app_name
  deployment_group_name = module.codedeploy.deployment_group_name
  codepipeline_role_id = module.iam.codepipeline_role_id
  codepipeline_bucket_arn = module.s3.codepipeline_bucket_arn
  github_connection_arn = module.codestar.github_connection_arn
  ec2_codedeploy_role_name = module.iam.ec2_codedeploy_role_name
  ec2_s3_access_policy_arn = module.iam.ec2_s3_access_policy_arn
}
