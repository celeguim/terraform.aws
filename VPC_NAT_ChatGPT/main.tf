module "vpc1" {
  source               = "./vpc1"
  vpc_cidr             = var.vpc1_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  instance_type        = var.instance_type
}

module "vpc2" {
  source               = "./vpc2"
  vpc_cidr             = var.vpc2_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  instance_type        = var.instance_type
}
