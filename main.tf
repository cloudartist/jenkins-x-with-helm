provider "aws" {
  region  = "eu-west-1"
  profile = "my-dev"
}

module "eks-jx" {
  source                               = "jenkins-x/eks-jx/aws"
  enable_worker_groups_launch_template = true
  allowed_spot_instance_types          = ["m5.large", "m5a.large", "m5d.large", "m5ad.large", "t3.large", "t3a.large"]
  lt_desired_nodes_per_subnet          = 1
  lt_min_nodes_per_subnet              = 1
  lt_max_nodes_per_subnet              = 1
  cluster_version                      = "1.21"
  nginx_chart_version                  = "3.12.0"
  region                               = "eu-west-1"
}

output "jx_requirements" {
  value = module.eks-jx.jx_requirements
}

output "vault_user_id" {
  value       = module.eks-jx.vault_user_id
  description = "The Vault IAM user id"
}

output "vault_user_secret" {
  value       = module.eks-jx.vault_user_secret
  description = "The Vault IAM user secret"
  sensitive = true
}
