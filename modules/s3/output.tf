output "codepipeline_bucket_arn" {
  value       = aws_s3_bucket.codepipeline_bucket.arn
  description = "ARN of the S3 bucket used for CodePipeline"
}

output "codepipeline_bucket_id" {
  value       = aws_s3_bucket.codepipeline_bucket.id
  description = "ID of the S3 bucket used for CodePipeline"
}

output "codepipeline_bucket_name" {
  value       = aws_s3_bucket.codepipeline_bucket.bucket
  description = "Name of the S3 bucket used for CodePipeline"
}

output "ojy_WEB_bucket_arn" {
  value = aws_s3_bucket.deploy_bucket.arn
}

output "ojy_WEB_bucket_id" {
  value = aws_s3_bucket.deploy_bucket.id
}

output "ojy_WEB_bucket_name" {
  value = aws_s3_bucket.deploy_bucket.bucket_domain_name
}

output "ojy_WEB_bucket_host_zone" {
  value = aws_s3_bucket.deploy_bucket.hosted_zone_id
}
