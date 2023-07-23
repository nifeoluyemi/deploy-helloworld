

module "vpc" {
  source = "../../terraform-module/aws-vpc"

  cidr_block = var.cidr_block

}