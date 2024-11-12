#### 도메인 이름 설정
variable "domain_name" {
    type        = string
    default     = "test.packet-punks.click"
    description = "Fully domain name to deploy Web services"
}

variable "validation_domain_name" {
    type        = string
    default     = "packet-punks.click"
    description = "Domain name for validation on acm"
}

variable "bucket_name" {
    type        = string
    default     = "pp-aws-S3"
    description = "Bucket name for S3"
}

variable "ojy_WEB_bucket_name" {
  type = string
}

variable "ojy_WEB_bucket_host_zone" {
  type = string
}