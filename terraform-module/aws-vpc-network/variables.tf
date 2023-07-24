
variable "vpc_id" {
  type        = string
  description = "VPC Id"
}

variable "tags" {
  description = "Resource Tags"
}

variable "elb_private_subnet_tags" {
  description = "Tags for subnets when creating elbs"
  type        = map(string)
  default = {
    "kubernetes.io/role/internal-elb" = "1"
  }
}

variable "elb_public_subnet_tags" {
  description = "Tags for subnets when creating elbs"
  type        = map(string)
  default = {
    "kubernetes.io/role/elb" = "1"
  }
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of subnets to create eks nodes"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "List of subnets to create eks nodes"
}