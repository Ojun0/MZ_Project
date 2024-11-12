#output "ec2_codedeploy_sg_id" {
#  description = "ID of the public subnet"
#  value       = aws_security_group.jdh_ec2_codedeploy_sg.id
#}
output "ojy_public_subnet_a_id" {
  value = aws_subnet.publicsubnet-a.id
}

output "ojy_public_subnet_c_id" {
  value = aws_subnet.publicsubnet-c.id
}

output "jdh_aws_VPC" {
  value = aws_vpc.jdh_aws_VPC.id
}

output "ojy_bastoin_ec2" {
  value = aws_instance.pp-aws-a-pub-Bastion-ec2
}