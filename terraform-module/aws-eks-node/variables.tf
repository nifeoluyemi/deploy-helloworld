
# Node group variables
variable "tags" {
  description = "Tags to apply to resources"
}

# Networking Vars
variable "subnet_ids" {
  type        = list(string)
  description = "List of subnets to create EKS nodes in"
}


# EKS Vars 
variable "cluster_name" {
  description = "Name of EKS cluster this noderoup will belong to"
  type        = string
}

variable "node_group_name" {
  description = "Name of node group"
  type        = string
  default     = "helloworld-node-group"
}

variable "kubernetes_version" {
  type        = string
  description = "(optional) Desired Kubernetes master version"
  default     = "1.27"
}

variable "node_groups_scaling" {
  type = object({
    desired_size = number
    max_size     = number
    min_size     = number
  })
  description = "Node group scaling settings"
}

variable "node_group_update_config" {
  type = object({
    max_unavailable            = number
    max_unavailable_percentage = number
  })
  description = "Node group update settings, only define one of the two options"
}

variable "disk_size" {
  type        = number
  description = "(Optional) Disk size in GiB for worker nodes."
}

variable "instance_types" {
  type        = list(string)
  description = "(Optional) List of instance types associated with the EKS Node Group"
}

