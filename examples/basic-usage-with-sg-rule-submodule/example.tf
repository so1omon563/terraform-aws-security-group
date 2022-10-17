# Basic usage with the Security Group rule submodule.

provider "aws" {
  default_tags {
    tags = {
      environment = "dev"
      terraform   = "true"
    }
  }
}

## Variables

variable "name" {
  type    = string
  default = "example-sg"
}

variable "tags" {
  type = map(string)
  default = {
    example = "true"
  }
}

## Create a VPC, since that is a requirement for a security group

module "vpc" {
  source  = "so1omon563/vpc/aws"
  version = "1.0.0"

  name = var.name
  tags = var.tags
}

## Security Group creation

module "web-sg" {
  source  = "so1omon563/security-group/aws"
  version = "1.0.0"

  name        = var.name
  vpc_id      = module.vpc.vpc_id
  type        = "web"
  description = "HTTP security group"
  tags        = var.tags
}

output "web-sg" {
  value = module.web-sg
}

module "db-sg" {
  source  = "so1omon563/security-group/aws"
  version = "1.0.0"

  name        = var.name
  vpc_id      = module.vpc.vpc_id
  type        = "db"
  description = "DB security group"
  tags        = var.tags
}

output "db-sg" {
  value = module.db-sg
}

## Security Group rules

module "web-rules" {
  depends_on = [
    module.web-sg
  ]
  for_each = toset(["80", "443"])
  source   = "so1omon563/security-group/aws//modules/basic_security_group_rule"
  version  = "1.0.0"

  from_port         = each.key
  protocol          = "TCP"
  security_group_id = module.web-sg.security-group.id
  to_port           = each.key
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  reciprocal_egress = true
  description       = "Web ports"
}

module "web-to-db" {
  depends_on = [
    module.web-sg,
    module.db-sg
  ]
  source  = "so1omon563/security-group/aws//modules/basic_security_group_rule"
  version = "1.0.0"

  from_port                = 3306
  protocol                 = "TCP"
  security_group_id        = module.web-sg.security-group.id
  to_port                  = 3306
  type                     = "egress"
  source_security_group_id = module.db-sg.security-group.id
  description              = "DB access"
}

module "web-self" {
  depends_on = [
    module.web-sg
  ]
  source  = "so1omon563/security-group/aws//modules/basic_security_group_rule"
  version = "1.0.0"

  from_port         = 0
  protocol          = "-1"
  security_group_id = module.web-sg.security-group.id
  to_port           = 0
  type              = "ingress"
  self              = true
  reciprocal_egress = true
  description       = "Open traffic to self"
}

module "db-self" {
  depends_on = [
    module.db-sg
  ]
  source  = "so1omon563/security-group/aws//modules/basic_security_group_rule"
  version = "1.0.0"

  from_port         = 0
  protocol          = "-1"
  security_group_id = module.db-sg.security-group.id
  to_port           = 0
  type              = "ingress"
  self              = true
  reciprocal_egress = true
  description       = "Open traffic to self"
}

module "web-egress-ephemeral" {
  depends_on = [
    module.web-sg
  ]
  source  = "so1omon563/security-group/aws//modules/basic_security_group_rule"
  version = "1.0.0"

  from_port         = 1024
  protocol          = "TCP"
  security_group_id = module.web-sg.security-group.id
  to_port           = 65535
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Ephemeral ports"
}

module "db-egress-ephemeral" {
  depends_on = [
    module.db-sg
  ]
  source  = "so1omon563/security-group/aws//modules/basic_security_group_rule"
  version = "1.0.0"

  from_port         = 1024
  protocol          = "TCP"
  security_group_id = module.db-sg.security-group.id
  to_port           = 65535
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Ephemeral ports"
}
