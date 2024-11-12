
resource "aws_cloudfront_origin_access_identity" "cloudfront_oai" {
    comment = "cloudfront_origin_access_identity comment"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
    #### 대상으로할 doamin을 지정 (여기서는 s3를 지정)
    origin {
        domain_name = aws_s3_bucket.deploy_bucket.bucket_domain_name
        origin_id   = aws_s3_bucket.deploy_bucket.id

        s3_origin_config {
            origin_access_identity = aws_cloudfront_origin_access_identity.cloudfront_oai.cloudfront_access_identity_path
        }

        #origin shiled는 원본의 부하를 줄이고 가용성을 증가시켜주는 캐싱 계층
        origin_shield {
            enabled = false
            origin_shield_region = "ap-northeast-2"
        }
    }

    enabled             = true
    is_ipv6_enabled     = true
    comment             = "test comment"
    default_root_object = "index.html"
    ##대체 도메인
    # aliases = [var.domain_name]

    ############## 캐시 동작 설정##############
    default_cache_behavior {
        allowed_methods  = ["GET", "HEAD"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = aws_s3_bucket.deploy_bucket.id

        forwarded_values {
            query_string = false

            cookies {
                forward = "none"
            }
        }

        viewer_protocol_policy = "redirect-to-https"
        min_ttl                = 0
        default_ttl            = 3600
        max_ttl                = 86400
    }

    ordered_cache_behavior {
        path_pattern     = "/*"
        allowed_methods  = ["GET", "HEAD"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = aws_s3_bucket.deploy_bucket.id

        forwarded_values {
            query_string = false

            cookies {
                forward = "none"
            }
        }

        min_ttl                = 0
        default_ttl            = 86400
        max_ttl                = 31536000
        compress               = true
        viewer_protocol_policy = "redirect-to-https"
    }

    ###################### 한국이 200대에 들어있기 때문에 클래스를 200으로설정###############
    price_class = "PriceClass_200"

    ########### 허용할 국가 설정
    restrictions {
        geo_restriction {
            restriction_type = "whitelist"
            locations        = ["KR"]
        }
    }

    tags = {
        Environment = "production"
    }

    ############### http ssl 인증서 설정 허용되는 
    viewer_certificate {
        acm_certificate_arn = aws_acm_certificate_validation.cert.certificate_arn
        ssl_support_method = "sni-only"
    }
}