module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "springpetclinic-cluster"
  cluster_version = "1.30"

  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.private[*].id

  # 🔥 VERY IMPORTANT
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  # Allow your Jenkins IP
  cluster_endpoint_public_access_cidrs = ["65.0.185.177/32"]

  eks_managed_node_groups = {
    default = {
      desired_size   = 2
      max_size       = 4
      min_size       = 2
      instance_types = ["c7i-flex.large"]
    }
  }

  tags = {
    Environment = "dev"
  }
}
