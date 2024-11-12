# CodePipeline 정의
resource "aws_codepipeline" "codepipeline" {
  name     = var.codepipeline_name
  role_arn = var.codepipeline_role_arn

  artifact_store {
    location = var.codepipeline_bucket_name 
    type     = "S3"
  }
#stage는 CodePipeline 내에서 실행되는 작업들의 집합, 순차적으로 진행

#GutHub에서 소스를 가져옴
  stage {
    name = "Source"

    action {
      name             = var.source_action_name    
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = var.codestar_github_connection_arn
        FullRepositoryId = var.github_repository_full_id
        BranchName       = var.github_branch_name
      }
    }
  }

#소스를 기반으로 빌드 수행
  stage {
    name = "Build"

    action {
      name             = var.build_action_name 
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = var.codebuild_project_name
      }
    }
  }

#build_output에서 받은 아티벡트 배포
  stage {
    name = "Deploy"

    action {
      name            = var.deploy_action_name
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        ApplicationName     = var.codedeploy_app_name
        DeploymentGroupName = var.deployment_group_name
      }
    }
  }
}

#### IAM
resource "aws_iam_role_policy" "codepipeline_policy" {
  role = var.codepipeline_role_id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:GetBucketVersioning",
          "s3:PutObjectAcl"
        ],
        Resource = [
          "${var.codepipeline_bucket_arn}/*",
          var.codepipeline_bucket_arn
        ]
      },
      {
        Effect = "Allow",
        Action = ["codestar-connections:UseConnection"],
        Resource = var.github_connection_arn
      },
      {
        Effect = "Allow",
        Action = ["codebuild:StartBuild", "codebuild:BatchGetBuilds"],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = ["codedeploy:*"],
        Resource = "*"
      }
    ]
  })
}

# Attach the S3 access policy to the EC2 role
resource "aws_iam_role_policy_attachment" "ec2_s3_access_attach" {
  role       = var.ec2_codedeploy_role_name
  policy_arn = var.ec2_s3_access_policy_arn
}
  