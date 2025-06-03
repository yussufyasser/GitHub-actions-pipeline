# Security Group for MongoDB EC2 (private)
resource "aws_security_group" "mongo_sg" {
 name = "mongo-sg"
 vpc_id = var.vpc-id
 ingress {
 description = "Allow MongoDB access from EKS pods"
 from_port = 27017
 to_port = 27017
 protocol = "tcp"
 security_groups = [var.eks_worker_sg_id]
 }
 ingress {
 description = "Allow SSH from Bastion"
 from_port = 22
 to_port = 22
 protocol = "tcp"
 security_groups = [aws_security_group.bastion_sg.id]
 }
 ingress {
 description = "Allow promethus to send to the mongo_sg"
 from_port = 9216
 to_port = 9216
 protocol = "tcp"
 security_groups = [aws_security_group.bastion_sg.id]
 }
 egress {
 from_port = 0
 to_port = 0
 protocol = "-1"
 cidr_blocks = ["0.0.0.0/0"]
 }
 tags = {
 Name = "MongoDB SG"
 }
}

# Security Group for Bastion (public)
resource "aws_security_group" "bastion_sg" {
 name = "bastion-sg"
 vpc_id = var.vpc-id
 ingress {
 description = "Allow SSH from admin IP"
 from_port = 22
 to_port = 22
 protocol = "tcp"
 cidr_blocks = [var.my_ip]
 }

ingress {
 description = "Allow accessing promethus"
 from_port = 9090
 to_port = 9090
 protocol = "tcp"
 cidr_blocks = [var.my_ip]
 }

 ingress {
 description = "Allow accessing graphana"
 from_port = 3000
 to_port = 3000
 protocol = "tcp"
 cidr_blocks = [var.my_ip]
 }

 egress {
 from_port = 0
 to_port = 0
 protocol = "-1"
 cidr_blocks = ["0.0.0.0/0"]
 }
 tags = {
 Name = "Bastion Host SG"
 }
}