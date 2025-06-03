resource "aws_instance" "mongodb" {
 ami = var.local-ami
 instance_type = "t2.micro"
 subnet_id = var.private-subnet
 vpc_security_group_ids = [var.mongo-sg]
 associate_public_ip_address = false
 key_name = var.key-name
 tags = {
 Name = "MongoDB-Private"
 }
}

resource "aws_instance" "bastion" {
 ami = var.local-ami
 instance_type = "t2.micro"
 subnet_id = var.public-subnet
 vpc_security_group_ids = [var.bastion-sg]
 associate_public_ip_address = true
 key_name = var.key-name
 tags = {
 Name = "Bastion-Public"
 }

user_data = templatefile("${path.module}/templates/user_data.sh.tpl", {
databaseip = aws_instance.instance.mongodb.private_ip
})
}