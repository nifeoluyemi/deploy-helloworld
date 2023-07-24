
resource "aws_eks_node_group" "node_group" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.node_group_name}"
  node_role_arn   = aws_iam_role.node_group_role.arn
  subnet_ids      = var.subnet_ids
  disk_size       = var.disk_size
  instance_types  = var.instance_types

  scaling_config {
    desired_size = var.node_groups_scaling.desired_size
    max_size     = var.node_groups_scaling.max_size
    min_size     = var.node_groups_scaling.min_size
  }

  update_config {
    max_unavailable            = var.node_group_update_config.max_unavailable
    max_unavailable_percentage = var.node_group_update_config.max_unavailable_percentage
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  tags = merge(
    var.tags,
    {
      Name        = "${var.node_group_name}"
      description = "AWS EKS nodegroup"
    }
  )

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}
