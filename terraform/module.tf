module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"

  name = "${var.cluster_name}-${random_string.cluster_suffix.result}"

  cidr = var.cluster_cidr
  azs  = slice(
    data.aws_availability_zones.available.names,
    0,
    3
  )

  private_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]
  public_subnets  = [
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/24"
  ]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}-${random_string.cluster_suffix.result}" = "shared"
    "kubernetes.io/role/elb"                                                           = 1
  }
  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}-${random_string.cluster_suffix.result}" = "shared"
    "kubernetes.io/role/internal-elb"                                                  = 1
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.13.1"

  cluster_name     = "${var.cluster_name}-${random_string.cluster_suffix.result}"
  cluster_version  = var.cluster_version

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    ami_type = var.ami_type
  }

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"

      instance_types = [
        var.instance_type
      ]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }

    two = {
      name = "node-group-2"
      instance_types = [
        var.instance_type
      ]
      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }
}

module "irsa-ebs-csi" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.17.0"

  create_role                   = true
  role_name                     = "AmazonEKSTFEBSCSIRole-${module.eks.cluster_name}"
  provider_url                  = module.eks.oidc_provider
  role_policy_arns              = [
    data.aws_iam_policy.ebs_csi_policy.arn
  ]
  oidc_fully_qualified_subjects = [
    "system:serviceaccount:kube-system:ebs-csi-controller-sa"
  ]
}

resource "aws_eks_addon" "ebs-csi" {
  cluster_name             = module.eks.cluster_name
  addon_name               = "aws-ebs-csi-driver"
  addon_version            = "v1.5.2-eksbuild.1"
  service_account_role_arn = module.irsa-ebs-csi.iam_role_arn
  tags = {
    "eks_addon" = "ebs-csi"
    "terraform" = "true"
  }
}

