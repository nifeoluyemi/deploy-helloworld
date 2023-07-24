

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

module "cluster" {
  source = "../../terraform-module/aws-eks"

  tags = var.tags

  vpc_id                    = module.vpc.vpc_id
  subnet_ids                = flatten([module.vpc_network.public_subnet_ids, module.vpc_network.private_subnet_ids])
  public_access_cidrs       = var.public_access_cidrs
  kubernetes_version        = var.kubernetes_version
  enabled_cluster_log_types = var.enabled_cluster_log_types
}

module "node_group" {
  source = "../../terraform-module/aws-eks-node"

  tags = var.tags

  cluster_name             = module.cluster.cluster_name
  node_group_name          = var.node_group_name
  subnet_ids               = module.vpc_network.private_subnet_ids
  node_groups_scaling      = var.node_groups_scaling
  node_group_update_config = var.node_group_update_config
  disk_size                = var.disk_size
  kubernetes_version       = var.kubernetes_version
  instance_types           = var.instance_types
}


# install flask-app

locals {
 chart_path = format("%s/%s", abspath("${path.module}/../.."), "helm-flask-app") 
}

module "helm-flask-app" {
  source = "../../terraform-module/flask-app-bootstrap"

  chart_path = local.chart_path
}