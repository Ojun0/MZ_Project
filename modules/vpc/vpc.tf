# VPC 생성
resource "aws_vpc" "jdh_aws_VPC" {
  cidr_block           = var.jdh_aws_VPC_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    User = "jeondohyeon"
    Team = "pp"
    Startdate = "20241101"
    Enddate = "20241212"
    Env = "prod"
    Name = "pp-aws-VPC"
  }
}

resource "aws_subnet" "publicsubnet-a" {
    vpc_id = aws_vpc.jdh_aws_VPC.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-northeast-2a"

    map_public_ip_on_launch = true
    
    tags = {
        User = "jeondohyeon"
        Team = "pp"
        Startdate = "20241101"
        Enddate = "20241212"
        Env = "prod"
        Name = "${var.name}-a-pub-subnet"
    }
}

resource "aws_subnet" "publicsubnet-c" {
    vpc_id = aws_vpc.jdh_aws_VPC.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "ap-northeast-2c"

    map_public_ip_on_launch = true
    
    tags = {
        User = "junyounoh"
        Team = "pp"
        Startdate = "20241101"
        Enddate = "20241212"
        Env = "prod"
        Name = "${var.name}-c-pub-subnet"
    }
}

resource "aws_subnet" "privatesubnet-a" {
    count = length(var.aws_private_subnets_a)
    vpc_id = aws_vpc.jdh_aws_VPC.id
    cidr_block = var.aws_private_subnets_a[count.index]
    availability_zone = "ap-northeast-2a"
    map_public_ip_on_launch = false

    tags = {
        User = "junyounoh"
        Team = "pp"
        Startdate = "20241101"
        Enddate = "20241212"
        Env = "prod"
        Name = var.aws_private_subnets_name_a[count.index]
    }
}

resource "aws_subnet" "privatesubnet-c" {
    count = length(var.aws_private_subnets_c)
    vpc_id = aws_vpc.jdh_aws_VPC.id
    cidr_block = var.aws_private_subnets_c[count.index]
    availability_zone = "ap-northeast-2c"
    map_public_ip_on_launch = false

    tags = {
        User = "junyounoh"
        Team = "pp"
        Startdate = "20241101"
        Enddate = "20241212"
        Env = "prod"
        Name = var.aws_private_subnets_name_c[count.index]
    }
}

# 인터넷 게이트웨이 생성
resource "aws_internet_gateway" "jdh_igw" {
  vpc_id = aws_vpc.jdh_aws_VPC.id

  tags = {
    User = "jeondohyeon"
    Team = "pp"
    Startdate = "20241101"
    Enddate = "20241212"
    Env = "prod"
    Name = "pp-IGW"
  }
}

# Public Subnet에 부여할 가용역역 a public Routing Table의 규칙을 생성 
resource "aws_route_table" "pp-aws-publicRT-a" {
    vpc_id = aws_vpc.jdh_aws_VPC.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.jdh_igw.id
    }
    tags = {
        User = "junyounoh"
        Team = "pp"
        Startdate = "20241101"
        Enddate = "20241212"
        Env = "prod"
        Name = "${var.name}-publicRT-a"
    }
}


# Public Subnet에 부여할 가용역역 c public Routing Table의 규칙을 생성 #################
resource "aws_route_table" "pp-aws-publicRT-c" {
    vpc_id = aws_vpc.jdh_aws_VPC.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.jdh_igw.id
    }
    tags = {
        User = "junyounoh"
        Team = "pp"
        Startdate = "20241101"
        Enddate = "20241212"
        Env = "prod"
        Name = "${var.name}-publicRT-c"
    }
}

############## Private Routing Table 생성 #########################
resource "aws_route_table" "pp-aws-privateRT-a" {
    vpc_id = aws_vpc.jdh_aws_VPC.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.pp-aws-nat-a.id
        # network_interface_id = aws_network_interface.pp-aws-a-bastion-ec2-nei.id
    }
    tags = {
        User = "junyounoh"
        Team = "pp"
        Startdate = "20241101"
        Enddate = "20241212"
        Env = "prod"
        Name = "${var.name}-privateRT-a"
    }
}

#생성해둔 AMI를 통하여 nat instance 생성
resource "aws_instance" "pp-aws-a-pub-Bastion-ec2" {
  ami           = "ami-013c2446bef83f52c"  
  instance_type = "t2.medium"
  subnet_id = aws_subnet.publicsubnet-a.id              
  security_groups = [var.ojy_bastion_sg]
  source_dest_check = false

  tags = {
    User = "junyounoh"
    Team = "pp"
    Startdate = "20241101"
    Enddate = "20241212"
    Env = "prod"
    Name = "pp-aws-a-pub-Bastion-ec2"
  }
}

resource "aws_eip" "nat_eip_a" {
  vpc = true
}

resource "aws_nat_gateway" "pp-aws-nat-a" {
  allocation_id = aws_eip.nat_eip_a.id
  subnet_id     = aws_subnet.publicsubnet-a.id

  tags = {
    User = "junyounoh"
    Team = "pp"
    Startdate = "20241101"
    Enddate = "20241212"
    Env = "prod"
    Name = "pp-aws-nat-a"
  }

  depends_on = [aws_internet_gateway.jdh_igw]
}


resource "aws_route_table" "pp-aws-privateRT-c" {
    vpc_id = aws_vpc.jdh_aws_VPC.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.pp-aws-nat-a.id
        # network_interface_id = aws_network_interface.pp-aws-c-bastion-ec2-nei.id
    }
    tags = {
        User = "junyounoh"
        Team = "pp"
        Startdate = "20241101"
        Enddate = "20241212"
        Env = "prod"
        Name = "${var.name}-privateRT-c"
    }
}


# Public Subnet에 위에서 생성한 aws_route_table을 연결#########################
resource "aws_route_table_association" "Public_a_routing" {

    route_table_id = aws_route_table.pp-aws-publicRT-a.id
    subnet_id = aws_subnet.publicsubnet-a.id
}

resource "aws_route_table_association" "Public_c_routing" {

    route_table_id = aws_route_table.pp-aws-publicRT-c.id
    subnet_id = aws_subnet.publicsubnet-c.id
}

# Private Subnet에 위에서 생성한 aws_route_table을 연결
resource "aws_route_table_association" "Private_a_routing" {
    count = length(var.aws_private_subnets_a)

    route_table_id = aws_route_table.pp-aws-privateRT-a.id
    subnet_id = aws_subnet.privatesubnet-a.*.id[count.index]
}

resource "aws_route_table_association" "Private_c_routing" {
    count = length(var.aws_private_subnets_c)

    route_table_id = aws_route_table.pp-aws-privateRT-c.id
    subnet_id = aws_subnet.privatesubnet-c.*.id[count.index]
}

