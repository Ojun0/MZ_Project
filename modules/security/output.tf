output "ojy_bastoin_sg" {
  value = aws_security_group.ojy_bastoin_sg.id
}

output "ojy_WEB_ALB_sg" {
  value = aws_security_group.ojy_WEB_ALB_sg.id
}

output "ojy_WEB_sg" {
  value = aws_security_group.ojy_WEB_sg.id
}

output "ojy_WAS_ALB_sg" {
  value = aws_security_group.ojy_WAS_ALB_sg.id
}

output "ojy_WAS_sg" {
  value = aws_security_group.ojy_WAS_sg.id
}

output "jdh_codedeploy_sg" {
  value = aws_security_group.jdh_ec2_codedeploy_sg.id
}