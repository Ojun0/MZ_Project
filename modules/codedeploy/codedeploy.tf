# CodeDeploy Application
resource "aws_codedeploy_app" "app" {
  name             = var.codedeploy_app_name
  compute_platform = var.codedeploy_compute_platform
}

#########                         #########
###### 나중에 배포 방식 변경해야할 듯 ######
#########                        #########
# CodeDeploy Deployment Group (IN_PLACE 배포 스타일 사용)
resource "aws_codedeploy_deployment_group" "deployment_group" {
  app_name              = aws_codedeploy_app.app.name
  deployment_group_name = var.deployment_group_name
  service_role_arn      = var.codedeploy_role_arn 

  deployment_style {
    deployment_type   = var.deployment_type
    deployment_option = var.deployment_option
  }

  # EC2 인스턴스를 대상으로 설정
  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      value = var.deployment_ec2_name
      type  = "KEY_AND_VALUE"
    }
  }
}

