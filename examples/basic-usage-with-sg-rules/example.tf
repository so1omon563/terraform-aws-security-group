# Basic usage with the Security Group rules

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
  default = "example-sg-main"
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
  depends_on = [
    module.db-sg
  ]
  source  = "so1omon563/security-group/aws"
  version = "1.0.0"

  name        = var.name
  vpc_id      = module.vpc.vpc_id
  type        = "web"
  description = "HTTP security group"
  tags        = var.tags
  rules = {
    http = {
      description              = "HTTP"
      reciprocal_egress        = false
      type                     = "ingress"
      from_port                = 80
      to_port                  = 80
      protocol                 = "TCP"
      cidr_blocks              = ["0.0.0.0/0"]
      self                     = false
      ipv6_cidr_blocks         = null
      prefix_list_ids          = null
      source_security_group_id = null
    }
    https = {
      description              = "HTTPS"
      reciprocal_egress        = false
      type                     = "ingress"
      from_port                = 443
      to_port                  = 443
      protocol                 = "TCP"
      cidr_blocks              = ["0.0.0.0/0"]
      self                     = false
      ipv6_cidr_blocks         = null
      prefix_list_ids          = null
      source_security_group_id = null
    }
    self = {
      description              = "Open traffic to self"
      reciprocal_egress        = true
      type                     = "ingress"
      from_port                = 0
      to_port                  = 0
      protocol                 = "-1"
      cidr_blocks              = ["0.0.0.0/0"]
      self                     = true
      ipv6_cidr_blocks         = null
      prefix_list_ids          = null
      source_security_group_id = null
    }
    ephemeral = {
      description              = "Ephemeral ports"
      reciprocal_egress        = false
      type                     = "egress"
      from_port                = 1024
      to_port                  = 65535
      protocol                 = "TCP"
      cidr_blocks              = ["0.0.0.0/0"]
      self                     = false
      ipv6_cidr_blocks         = null
      prefix_list_ids          = null
      source_security_group_id = null
    }
    web-to-db = {
      description              = "DB access"
      reciprocal_egress        = false
      type                     = "egress"
      from_port                = 3306
      to_port                  = 3306
      protocol                 = "TCP"
      cidr_blocks              = null
      self                     = false
      ipv6_cidr_blocks         = null
      prefix_list_ids          = null
      source_security_group_id = module.db-sg.security-group.id
    }
  }
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
  rules = {
    self = {
      description              = "Open traffic to self"
      reciprocal_egress        = true
      type                     = "ingress"
      from_port                = 0
      to_port                  = 0
      protocol                 = "-1"
      cidr_blocks              = ["0.0.0.0/0"]
      self                     = true
      ipv6_cidr_blocks         = null
      prefix_list_ids          = null
      source_security_group_id = null
    }
    ephemeral = {
      description              = "Ephemeral ports"
      reciprocal_egress        = false
      type                     = "egress"
      from_port                = 1024
      to_port                  = 65535
      protocol                 = "TCP"
      cidr_blocks              = ["0.0.0.0/0"]
      self                     = false
      ipv6_cidr_blocks         = null
      prefix_list_ids          = null
      source_security_group_id = null
    }
  }
}

output "db-sg" {
  value = module.db-sg
}
