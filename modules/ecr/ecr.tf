# ECR Repository
resource "aws_ecr_repository" "jdh_image" {
  name = var.jdh_image_name

  tags = {
    User = "jeondohyeon"
    Team = "pp"
    Startdate = "20241101"
    Enddate = "20241212"
    Env = "prod"
    Name = "pp-IGW"
  }
}

# ECR Lifecycle Policy
resource "aws_ecr_lifecycle_policy" "jdh_image_lifecycle_policy" {
  repository = aws_ecr_repository.jdh_image.name

  policy = <<EOF
  {
    "rules": [
      {
        "rulePriority": 1,
        "description": "Expire untagged images older than 30 days",
        "selection": {
          "tagStatus": "untagged",
          "countType": "sinceImagePushed",
          "countUnit": "days",
          "countNumber": 30
        },
        "action": {
          "type": "expire"
        }
      }
    ]
  }
  EOF
}

