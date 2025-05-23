output "bastion_public_ip" {
  description = "Public IP of the bastion host"
  value       = aws_instance.bastion.public_ip
}

output "private_ec2_private_ip" {
  description = "Private IP of the private EC2 instance"
  value       = aws_instance.mongodb.private_ip
}
