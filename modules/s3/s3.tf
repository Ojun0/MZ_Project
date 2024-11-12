# S3 Bucket for Pipeline Artifacts
resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = var.codepipeline_bucket_name

  tags = {
      User = "jeondohyeon"
      Team = "pp"
      Startdate = "20241101"
      Enddate = "20241212"
      Env = "prod"
      Name = "pp-aws-S3"
    }
}

# S3 Bucket Versioning
resource "aws_s3_bucket_versioning" "codepipeline_bucket_versioning" {
  bucket = aws_s3_bucket.codepipeline_bucket.id
  versioning_configuration {
    status = var.codepipeline_bucket_versioning_status
  }
}

resource "aws_s3_bucket_public_access_block" "codepipeline_bucket_pab" {
  bucket = aws_s3_bucket.codepipeline_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket" "deploy_bucket" {
    bucket = "packet-punks.click"

    tags = {
      User = "junyoungoh"
      Team = "pp"
      Startdate = "20241101"
      Enddate = "20241212"
      Env = "prod"
      Name = "pp-aws-S3"
    }

    force_destroy = true
}


#### 버킷 객체 소유권 버킷 오너에게 준다.
resource "aws_s3_bucket_ownership_controls" "s3-ownership" {
  bucket = aws_s3_bucket.deploy_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

### 퍼블릭 액세스 차단하지 않는다.
resource "aws_s3_bucket_public_access_block" "s3-access" {
  bucket = aws_s3_bucket.deploy_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

##### acl 비활성화
resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.s3-ownership,
    aws_s3_bucket_public_access_block.s3-access,
  ]

  bucket = aws_s3_bucket.deploy_bucket.id
  acl    = "public-read"
}

####### GetOnject에 대해서 모두 허용
data "aws_iam_policy_document" "s3_policy" {
  depends_on = [
    aws_s3_bucket_acl.example
  ]
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.deploy_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

###### GetOnject에 대해서 모두 허용
resource "aws_s3_bucket_policy" "example" {
  bucket = aws_s3_bucket.deploy_bucket.id
  policy = data.aws_iam_policy_document.s3_policy.json
}

########## 정적 웹 서비스 호스팅 설정 
resource "aws_s3_bucket_website_configuration" "website-config" {
  bucket = aws_s3_bucket.deploy_bucket.id
  index_document {
    suffix = "index.html"
  }
}