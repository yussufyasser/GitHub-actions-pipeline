output "mongo_sg_id" {
  value = aws_security_group.mongo_sg.id
}

output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}