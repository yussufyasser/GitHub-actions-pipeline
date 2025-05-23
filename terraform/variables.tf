variable "public_subnet_id" {}

variable "private_subnet_id" {}

variable "eks_worker_sg_id" {
}

variable "my_ip" {
  default = "0.0.0.0/0"
}


variable "vpc_id" {}


variable "key_name" {
  default = "my-ec2-key"
}


variable "ami_id" {
  default = "ami-0e58b56aa4d64231b"
}