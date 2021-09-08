###############
## Providers ##
###############

provider "aws" {
  region = local.aws_region
}

################################
## Terraform Required Version ##
################################

terraform {
  required_version = ">= 0.12"
}

#############################
## Global Variables Module ##
#############################

module "global_variables" {
  source  = "app.terraform.io/stash/variables/global"
  version = "~>0.10"
}

locals {
  # General
  aws_account_name = var.workspace_account
  aws_region       = module.global_variables.aws_region[var.workspace_account]
  environment      = var.workspace_environment

  # Networking
  vpc_id          = module.global_variables.aws_vpc_id[var.workspace_account][var.workspace_environment]
  priv_subnet_ids = module.global_variables.aws_priv_subnet_ids[var.workspace_account][var.workspace_environment]

  # Security Group
  dmz_ingress_vpc_cidr = module.global_variables.aws_vpc_cidr_block["dmz"]["ingress"]
  vpc_cidr_block       = module.global_variables.aws_vpc_cidr_block[var.workspace_account][var.workspace_environment]
}

############################
## Kubernetes Dev Workers ##
############################

module "k8s_akeyless_gateway" {
  source   = "app.terraform.io/stash/k8s-wk/aws"
  version  = "~>0.8.0"
  app_name = var.app_name

  aws_account_name = local.aws_account_name
  aws_region       = local.aws_region
  environment      = local.environment

  vpc_id          = local.vpc_id
  vpc_cidr_block  = local.vpc_cidr_block
  priv_subnet_ids = local.priv_subnet_ids

  asg_max_size         = var.asg_max_size
  asg_min_size         = var.asg_min_size
  asg_desired_capacity = var.asg_desired_capacity

  key_name = var.key_name
}

##############################
## ASG Security Group Rules ##
##############################

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [local.dmz_ingress_vpc_cidr]
  security_group_id = module.k8s_akeyless_gateway.k8s_wk_sg_id
}

/*
resource "aws_security_group_rule" "web_ui" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "tcp"
  cidr_blocks       = ["172.21.1.129/32"]
  security_group_id = module.k8s_akeyless_gateway.k8s_wk_sg_id
}
*/
