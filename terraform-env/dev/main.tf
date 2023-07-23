

module "vpc" {
  source = "../../terraform-module/aws-vpc"

  cidr_block = var.cidr_block
}


module "vpc_network" {
  source = "../../terraform-module/aws-vpc-network"

  vpc_id                        = module.vpc.vpc_id
  public_subnet_cidrs           = var.public_subnet_cidrs
  private_subnet_cidrs          = var.private_subnet_cidrs

  tags = var.tags
}