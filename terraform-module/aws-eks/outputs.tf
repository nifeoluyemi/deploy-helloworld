
output "cluster_endpoint" {
  value = aws_eks_cluster.helloworld.endpoint
}

output "cluster_name" {
  value = aws_eks_cluster.helloworld.name
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.helloworld.certificate_authority[0].data
}