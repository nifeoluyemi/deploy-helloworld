
variable "tags" {
  description = "Tags to apply to resources"
}

variable "vpc_id" {
  type        = string
  description = "ID of VPC that resources will be deployed into"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnets to create EKS nodes in"
}


# EKS Vars 
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