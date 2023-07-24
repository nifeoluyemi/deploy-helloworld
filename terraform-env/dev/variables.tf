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


# cluster vars

variable "kubernetes_version" {
  type        = string
  description = "(optional) Desired Kubernetes master version"
  default     = "1.27"
}

variable "public_access_cidrs" {
  type        = list(string)
  description = "List of CIDR blocks that can access the Amazon EKS public API server endpoint when enabled"
  default     = ["0.0.0.0/0"]
}

variable "enabled_cluster_log_types" {
  type        = list(string)
  description = "(Optional) List of the desired control plane logging to enable"
  default     = ["api", "audit"]
}


# Node group vars
variable "node_group_name" {
  description = "Name of node group"
  type        = string
  default     = "helloworld-node-group"
}

variable "node_groups_scaling" {
  type = object({
    desired_size = number
    max_size     = number
    min_size     = number
  })
  default = {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }
  description = "Node group scaling settings"
}

variable "node_group_update_config" {
  type = object({
    max_unavailable            = number
    max_unavailable_percentage = number
  })
  default = {
    max_unavailable            = 1
    max_unavailable_percentage = null
  }
  description = "Node group update settings, only define one of the two options"
}

variable "disk_size" {
  type        = number
  description = "(Optional) Disk size in GiB for worker nodes."
  default     = 20
}

variable "instance_types" {
  type        = list(string)
  description = "(Optional) List of instance types associated with the EKS Node Group"
  default     = ["t2.medium"]
}

