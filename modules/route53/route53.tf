########### 이미 생성해둔 호스팅 영역 받아오기 cloudfront 사용시
data "aws_route53_zone" "route53_host_zone" {
    name = var.validation_domain_name
}

####### 클로우드 프론트와 연결된 a레코드 생성
resource "aws_route53_record" "route53_record_a_eb_test" {
    zone_id = data.aws_route53_zone.route53_host_zone.zone_id
    name    = var.domain_name
    type    = "A"

    alias {
        name = "${var.ojy_WEB_bucket_name}"
        zone_id = "${var.ojy_WEB_bucket_host_zone}"
        evaluate_target_health = false
    }
}


# data "aws_route53_zone" "front" {
#   name         = var.domain_name
#   private_zone = false
# }

# resource "aws_route53_record" "front" {
#   zone_id = data.aws_route53_zone.front.zone_id
#   name    = var.domain_name
#   type    = "A"

#   alias {
#     name                   = aws_lb.pp-aws-WEB-ALB.dns_name
#     zone_id                = aws_lb.pp-aws-WEB-ALB.zone_id
#     evaluate_target_health = true
#   }
# }

# resource "aws_route53_record" "cert_validation" {
#   name    = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_name
#   type    = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_type
#   zone_id = data.aws_route53_zone.front.zone_id
#   records = [tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_value]
#   ttl     = 60
# }