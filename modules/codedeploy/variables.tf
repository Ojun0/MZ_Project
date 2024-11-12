variable "codedeploy_app_name" {
  description = "Name of codedeploy app"
  type        = string
  default     = "jdh-testApplication"
}


variable "codedeploy_compute_platform" {
  description = "Set codedeploy compute platform"
  type        = string
  default     = "Server"
}
# 위 변수(codedeploy_compute_platform)의 옵션 값
#"Server": EC2 인스턴스나 온프레미스 서버에 배포
#"Lambda": AWS Lambda 함수에 배포
#"ECS": Amazon ECS (Elastic Container Service)에 배포


variable "deployment_group_name" {
  description = "Set deployment group name"
  type        = string
  default     = "testDeploymentGroup"
}

variable "codedeploy_role_arn" {
  description = "put codedeploy role arn"
  type        = string
}


#배포 타입 설정
variable "deployment_type" {
  description = "Set deployment type"
  type        = string
  default     = "IN_PLACE"
}
# 위 변수(deployment_type)의 옵션 값
### "IN_PLACE": 기존 인스턴스를 업데이트하는 방식의 배포
### "BLUE_GREEN": 새 리소스를 생성하고 트래픽을 전환하는 방식의 배포


variable "deployment_option" {
  description = "Set deployment option"
  type        = string
  default     = "WITHOUT_TRAFFIC_CONTROL"
}
# 위 변수(deployment_option)의 옵션 값
### WITHOUT_TRAFFIC_CONTROL
### 배포 시 별도의 트래픽 전환 단계 없이 즉시 배포를 진행합니다.
### 단순한 배포에 적합하며, 트래픽 제어 없이 빠르게 업데이트하고자 할 때 사용합니다.
### WITH_TRAFFIC_CONTROL
### 배포 시 새로운 애플리케이션 버전으로 트래픽을 점진적으로 전환하여 트래픽 제어를 제공합니다.
### 트래픽을 새 버전으로 천천히 전환하면서 문제가 발생하면 롤백할 수 있는 옵션입니다.
### BLUE_GREEN 배포 방식과 주로 함께 사용됩니다.

variable "deployment_ec2_name" {
  description = "Set deployment ec2 name"
  type        = string
  default     = "CodeDeployInstance"
}