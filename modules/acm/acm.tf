provider "aws" {
  region = "us-east-1"
  alias = "virginia"
}

############## ssl 인증서 생성 라우트53과 연결해서 DNS CNAME 레코드 등록하는 방식#####
resource "aws_acm_certificate" "cert" {
    provider          = aws.virginia
    domain_name       = var.domain_name
    validation_method = "DNS"

    validation_option {
        domain_name       = var.domain_name
        validation_domain = var.validation_domain_name
    }


    lifecycle {
        create_before_destroy = true
    }
}


data "aws_route53_zone" "example" {
    name         = var.validation_domain_name
    private_zone = false
}

######## 인증을 위한 레코드 등록과 설정
resource "aws_route53_record" "example" {
    for_each = {
        for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
        name   = dvo.resource_record_name
        record = dvo.resource_record_value
        type   = dvo.resource_record_type
        }
    }

    allow_overwrite = true
    name            = each.value.name
    records         = [each.value.record]
    ttl             = 60
    type            = each.value.type
    zone_id         = data.aws_route53_zone.example.zone_id
}
######## 인증을 위한 레코드 등록과 설정
resource "aws_acm_certificate_validation" "example" {
    provider                = aws.virginia
    certificate_arn         = aws_acm_certificate.cert.arn
    validation_record_fqdns = [for record in aws_route53_record.example : record.fqdn]
}

# ############### 위는 cloudfront 사용시 ###########
# resource "aws_acm_certificate" "cert" {
#   domain_name       = var.domain_name
#   validation_method = "DNS"
#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "aws_acm_certificate_validation" "cert" {
#   certificate_arn         = aws_acm_certificate.cert.arn
#   validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
# }
