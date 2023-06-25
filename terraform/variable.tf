variable "ami_type" {
  description = "The type of Amazon Machine Image (AMI) associated with the EKS Node Group."
  type        = string
  default     = "AL2_x86_64"
}

variable "instance_type" {
  description = "The type of Amazon machine instances associated with the EKS Node Group."
  type        = string
  default     = "t3.small"
}

variable "aws_region" {
  description = "The designated Amazon Web Services region."
  type        = string
  default     = "eu-central-1"
}

variable "cluster_cidr" {
  description = "The Classless Inter-Domain Routing of the Kubernetes cluster."
  type        = string
  default     = "10.0.0.0/16"
}

variable "cluster_name" {
  description = "The name of the Kubernetes cluster."
  type        = string
  default     = "mock_cluster"
}

variable "cluster_version" {
  description = "The version of the Kubernetes cluster."
  type        = string
  default     = "1.24"
}

variable "suffix_length" {
  description = "The length of the unique suffix of the Kubernetes cluster name."
  type        = number
  default     = 8
}
