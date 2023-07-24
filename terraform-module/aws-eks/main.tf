

# Eks cluster
resource "aws_eks_cluster" "helloworld" {
  name = "${var.tags.service}-${var.tags.environment}-cluster"

  role_arn = aws_iam_role.control_plane_role.arn

  vpc_config {
    subnet_ids             = var.subnet_ids
    public_access_cidrs    = var.public_access_cidrs
  }
  
  enabled_cluster_log_types = var.enabled_cluster_log_types
  version                   = var.kubernetes_version


  tags = merge(
    var.tags,
    {
      Name        = "${var.tags.service}-${var.tags.environment}-cluster"
      description = "AWS EKS cluster"
    }
  )

  depends_on = [ 
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController
  ]
}
