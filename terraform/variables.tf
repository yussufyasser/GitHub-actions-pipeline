variable "vpc-id" {
  default = "vpc-0537d654d83b9d6ab"
}

variable "private-subnet_id" {
  default = "subnet-0402ab85bb446ca6d"
}

variable "public_subnet_id" {
  default = "subnet-0247a495353a38021"
}


variable "eks_worker_sg_id" {
  default = "sg-0e29193bd03cbf6cb"
}


variable "my_ip" {
  default = "0.0.0.0/0"
}


variable "key_name" {
  default = "my-ec2-key.pem"
}


variable "ami_id" {
  default = "ami-0c02fb55956c7d316"
}