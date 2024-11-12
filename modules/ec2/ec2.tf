# EC2 Instance for CodeDeploy with CodeDeploy Agent Installation
# iam 참조하니 모듈 호출 필요
resource "aws_instance" "code_deploy_instance" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t3.medium"
  subnet_id              = var.code_deploy_subnet_id 
  iam_instance_profile   = var.codedeploy_instance_profile_id
  vpc_security_group_ids = [var.ec2_codedeploy_sg_id]  # 보안 그룹 추가

  tags = {
    Name = var.code_deploy_instance_name
    User = "jeondohyeon"
    Team = "pp"
    Startdate = "20241101"
    Enddate = "20241212"
    Env = "prod"
  }

  associate_public_ip_address = true
# appspec.yml에 nginx경로를 찾아야하는데 nginx설치 전이라 못찾아서 nginx를 먼저 설치해 경로를 만들어 놓음
  user_data = <<-EOF
            #!/bin/bash
            sudo yum update -y

            sudo amazon-linux-extras enable nginx1
            sudo yum install -y nginx
            sudo systemctl enable nginx
            sudo systemctl start nginx

            sudo yum install -y ruby wget
            cd /home/ec2-user
            wget https://aws-codedeploy-ap-northeast-2.s3.ap-northeast-2.amazonaws.com/latest/install
            chmod +x ./install
            sudo ./install auto
            sudo systemctl enable codedeploy-agent
            sudo systemctl start codedeploy-agent

            sudo yum install docker -y
            sudo systemctl enable docker
            sudo systemctl start docker

            EOF
}

# 최신 Amazon Linux 2 AMI ID를 가져오기 위한 데이터 소스
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}


