##############codedeploy 

# EC2 인스턴스에서 CodeDeploy 에이전트를 실행하기 위한 IAM 역할 생성
resource "aws_iam_role" "ec2_codedeploy_role" {
  name = var.ec2_codedeploy_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

# EC2 인스턴스 관리용 AmazonSSMManagedInstanceCore 정책을 연결하여 SSM을 통해 EC2 관리 허용
resource "aws_iam_role_policy_attachment" "ec2_codedeploy_ssm_attach" {
  role       = aws_iam_role.ec2_codedeploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# EC2에서 CodeDeploy 접근을 위한 커스텀 IAM 정책
resource "aws_iam_policy" "ec2_codedeploy_policy" {
  name        = var.ec2_codedeploy_policy_name
  description = "Custom policy for EC2 to access CodeDeploy services"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "codedeploy:RegisterApplicationRevision",
          "codedeploy:GetApplication",
          "codedeploy:GetDeployment",
          "codedeploy:CreateDeployment",
          "codedeploy:RegisterOnPremisesInstance",
          "codedeploy:DeregisterOnPremisesInstance",
          "codedeploy:ListDeploymentGroups",
          "codedeploy:ListDeploymentConfigs",
          "codedeploy:GetDeploymentConfig"
        ],
        Resource = "*"
      }
    ]
  })
}

# 커스텀 CodeDeploy 정책을 EC2 IAM 역할에 연결
resource "aws_iam_role_policy_attachment" "ec2_codedeploy_jdh-policy_attach" {
  role       = aws_iam_role.ec2_codedeploy_role.name
  policy_arn = aws_iam_policy.ec2_codedeploy_policy.arn
}



# CodeDeploy를 위한 EC2 인스턴스 프로파일
resource "aws_iam_instance_profile" "ec2_codedeploy_instance_profile" {
  name = var.ec2_codedeploy_instance_profile_name
  role = aws_iam_role.ec2_codedeploy_role.name
}

##############codedeploy 


# IAM Roles and Policies
# CodePipeline IAM Role
resource "aws_iam_role" "codepipeline_role" {
  name = var.codepipeline_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "codepipeline.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}




# 코드빌드에서 참조 aws_iam_role.codebuild_role_updated.arn
# CodeBuild IAM Role with CloudWatch Logs and ECR Permissions
# CodeBuild에서 업데이트 작업을 수행할 수 있도록 필요한 권한을 생성
resource "aws_iam_role" "codebuild_role_updated" {
  name = var.codebuild_role_updated_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "codebuild.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "codebuild_policy" {
  role = aws_iam_role.codebuild_role_updated.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:ap-northeast-2:277707099377:log-group:/aws/codebuild/jdh-testBuildProject123*"
      },
      {
        Effect = "Allow",
        Action = [
          "ecr:GetAuthorizationToken",  # 추가된 권한
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:GetBucketVersioning"
        ],
        Resource = [
          "arn:aws:s3:::jdh-cicd-pipeline-artifacts-bucket",
          "arn:aws:s3:::jdh-cicd-pipeline-artifacts-bucket/*"
        ]
      }
    ]
  })
}

# CodeDeploy IAM Role
resource "aws_iam_role" "codedeploy_role" {
  name = var.codedeploy_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "codedeploy.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

# Attach AmazonEC2FullAccess to allow CodeDeploy to manage EC2
resource "aws_iam_role_policy_attachment" "codedeploy_ec2_access" {
  role       = aws_iam_role.codedeploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

# Attach AWSCodeDeployRole policy to allow CodeDeploy actions
resource "aws_iam_role_policy_attachment" "codedeploy_policy_attach" {
  role       = aws_iam_role.codedeploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}

resource "aws_iam_policy" "ec2_s3_access_policy" {
  name        = var.ec2_s3_access_policy_name
  description = "Policy for EC2 instances to access specific S3 bucket for CodeDeploy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::jdh-cicd-pipeline-artifacts-bucket",
          "arn:aws:s3:::jdh-cicd-pipeline-artifacts-bucket/*"
        ]
      }
    ]
  })
}

