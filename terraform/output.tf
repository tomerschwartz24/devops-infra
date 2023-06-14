output "aws_region" {
  description = "The designated Amazon Web Services region."
  value       = var.aws_region
}

output "cluster_endpoint" {
  description = "The IPv4 address of the deployed Kubernetes cluster."
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "The name of the deployed Kubernetes cluster."
  value       = module.eks.cluster_name
}
