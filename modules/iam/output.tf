output "ec2_codedeploy_role_name" {
  value = aws_iam_role.ec2_codedeploy_role.name
}

output "codebuild_role_updated_arn" {
  value = aws_iam_role.codebuild_role_updated.arn
}

output "ec2_codedeploy_instance_profile_id" {
  value = aws_iam_instance_profile.ec2_codedeploy_instance_profile.id

}

output "codepipeline_role_id" {
  value = aws_iam_role.codepipeline_role.id
}

output "codepipeline_role_arn" {
  value = aws_iam_role.codepipeline_role.arn
}

output "codedeploy_role_arn" {
  value = aws_iam_role.codedeploy_role.arn
}

output "ec2_s3_access_policy_arn" {
  value = aws_iam_policy.ec2_s3_access_policy.arn
}
