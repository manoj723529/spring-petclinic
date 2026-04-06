# -------------------------
# PUBLIC SUBNETS
# -------------------------
resource "aws_subnet" "public" {
  count = 2

  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet("10.0.0.0/16", 8, count.index)
  availability_zone       = element(["ap-south-1a", "ap-south-1b"], count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index}"

    # 🔥 REQUIRED for EKS LoadBalancer
    "kubernetes.io/role/elb" = "1"

    # 🔥 REQUIRED for EKS cluster
    "kubernetes.io/cluster/springpetclinic-cluster" = "shared"
  }
}

# -------------------------
# PRIVATE SUBNETS
# -------------------------
resource "aws_subnet" "private" {
  count = 2

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet("10.0.0.0/16", 8, count.index + 10)
  availability_zone = element(["ap-south-1a", "ap-south-1b"], count.index)

  tags = {
    Name = "private-subnet-${count.index}"

    # 🔥 REQUIRED for internal load balancer
    "kubernetes.io/role/internal-elb" = "1"

    # 🔥 REQUIRED for EKS cluster
    "kubernetes.io/cluster/springpetclinic-cluster" = "shared"
  }
}
