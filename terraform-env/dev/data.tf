data "aws_eks_cluster_auth" "cluster-auth" {
  depends_on = [ module.cluster ]
  name       = module.cluster.cluster_name
}