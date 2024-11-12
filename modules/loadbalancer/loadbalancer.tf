####
resource "aws_lb" "pp-aws-WEB-ALB" {
  name = "pp-aws-WEB-ALB"
  internal = false
  load_balancer_type = "application"
  security_groups = [var.ojy_WEB_ALB_sg]
  subnets = [var.ojy_public_subnet_a_id, var.ojy_public_subnet_c_id]
  
#   access_logs {
#     bucket  = aws_s3_bucket.log_storage.id
#     prefix  = "frontend-alb"
#     enabled = true
#   }

  tags = {
    User = "junyoungoh"
    Team = "pp"
    Startdate = "20241101"
    Enddate = "20241212"
    Env = "prod"
    Name = "pp-aws-web-ALB"
  }
}

## ALB TG생성
resource "aws_lb_target_group" "pp-aws-WEB-TG" {
  vpc_id                = var.jdh_aws_VPC
  name                  = "pp-aws-WEB-TG"
  port                  = "80"
  protocol              = "HTTP"
  target_type           = "ip"
  deregistration_delay  = 30

  health_check {
    interval            = 20
    path                = "/"
    timeout             = 5 #해당 시간내 응답이 없으면 실패
    matcher             = "200"
    healthy_threshold   = 2 ## 헬스 체크 문제 시 정상 요청 반환이 될 때까지의 최대 재요청 수
    unhealthy_threshold = 2 ## 헬스 체크 문제 시 최대 실패 횟수 limit
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "https_forward" {
  load_balancer_arn = var.staging
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.cert

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pp-aws-WEB-TG.id
  }
}
