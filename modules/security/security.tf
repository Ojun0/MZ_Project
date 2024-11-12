## bastion ec2
resource "aws_security_group" "ojy_bastoin_sg" {
  vpc_id = var.jdh_aws_VPC
  name = "pp-aws-bastion-sg"

  ingress {
    description = "Allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    User = "junyoungoh"
    Team = "pp"
    Startdate = "20241101"
    Enddate = "20241212"
    Env = "prod"
    Name = "pp-aws-bastion-sg"
  }
}


## WEB ALB https 허용
resource "aws_security_group" "ojy_WEB_ALB_sg" {
  vpc_id = var.jdh_aws_VPC
  name = "pp-aws-WEB-ALB-sg"

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    User = "junyoungoh"
    Team = "pp"
    Startdate = "20241101"
    Enddate = "20241212"
    Env = "prod"
    Name = "pp-aws-WEB-ALB-sg"
  }
}

### WEB ec2 ssh, https 허용
resource "aws_security_group" "ojy_WEB_sg" {
  vpc_id = var.jdh_aws_VPC
  name = "pp-aws-WEB-sg"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "Allow HTTP"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_groups = [var.ojy_WEB_ALB_sg]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    User = "junyoungoh"
    Team = "pp"
    Startdate = "20241101"
    Enddate = "20241212"
    Env = "prod"
    Name = "pp-aws-WEB-sg"
  }
}

### WAS ALB ec2 ssh, http ssh허용
resource "aws_security_group" "ojy_WAS_ALB_sg" {
  vpc_id = var.jdh_aws_VPC
  name = "pp-aws-WAS-ALB-sg"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "Allow HTTP"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_groups = [var.ojy_WEB_sg]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    User = "junyoungoh"
    Team = "pp"
    Startdate = "20241101"
    Enddate = "20241212"
    Env = "prod"
    Name = "pp-aws-WAS-ALB-sg"
  }
}


### WAS ec2 ssh, http 허용
resource "aws_security_group" "ojy_WAS_sg" {
  vpc_id = var.jdh_aws_VPC
  name = "pp-aws-WAS-sg"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "Allow HTTP"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_groups = [var.ojy_WAS_ALB_sg]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    User = "junyoungoh"
    Team = "pp"
    Startdate = "20241101"
    Enddate = "20241212"
    Env = "prod"
    Name = "pp-aws-WAS-sg"
  }
}
# CI/CD 보안 그룹 생성 (SSH 및 HTTP 허용)

resource "aws_security_group" "jdh_ec2_codedeploy_sg" {
  vpc_id = var.jdh_aws_VPC

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    User = "junyoungoh"
    Team = "pp"
    Startdate = "20241101"
    Enddate = "20241212"
    Env = "prod"
    Name = "pp-aws-codedeploy-sg"
  }
}
