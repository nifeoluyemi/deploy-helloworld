
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
