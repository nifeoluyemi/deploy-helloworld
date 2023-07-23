
variable "region" {
  type        = string
  description = "Region where resources are deployed"
  default     = "us-east-1"
}

variable "cidr_block" {
  type        = string
  description = ""
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of subnets to create eks nodes"
  default = [ "10.0.64.0/19", "10.0.96.0/19" ]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "List of subnets to create eks nodes"
  default = [ "10.0.0.0/19", "10.0.32.0/19" ]
}

variable "tags" {
  type        = map(string)
  description = "Resources Tags"
  default = {
    environment = "dev"
    managed_by  = "terraform"
    owner       = "oluyemine"
    service     = "helloworld"
  }
}
