module "security_groups" {
  source      = "./Modules/Security-Groups"
  my_ip = var.my_ip
  vpc-id = var.vpc-id
  eks_worker_sg_id = var.eks_worker_sg_id
}

module "ec2" {
  source              = "./Modules/EC2"
  mongo-sg = module.security_groups.mongo_sg_id
  bastion-sg = module.security_groups.bastion_sg_id
  key-name = var.key_name
  private-subnet = var.private_subnet_id
  public-subnet = var.public_subnet_id
  local-ami = var.ami_id
}