provider "aws" {
  region = "us-east-1"
}

resource "aws_eks_cluster" "mern_cluster" {
  name = "mern-cluster"
  role_arn = aws_iam_role.eks_role.arn
}

resource "aws_iam_role" "eks_role" {
  name = "eks-cluster-role"
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"]
}

