module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  cluster_name = "petclinic-cluster"

  vpc_id  = aws_vpc.main.id
  subnets = aws_subnet.private[*].id   # 👈 IMPORTANT

  node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 4
      min_capacity     = 2
    }
  }
}
