variable "name" {}
variable "tags" {}

module "vpc" {
  source  = "so1omon563/vpc/aws"
  version = "1.0.0"

  name = var.name
  tags = var.tags
}

module "security_group" {
  source = "../../.."

  tags   = var.tags
  name   = var.name
  vpc_id = module.vpc.vpc_id
}

output "security_group" { value = module.security_group }

module "sg-rule" {
  source = "../../../modules/basic_security_group_rule"

  from_port         = 80
  protocol          = "TCP"
  security_group_id = module.security_group.security-group.id
  to_port           = 80
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  reciprocal_egress = true
  description       = "Web access"
}

module "security_group_main_rules" {
  source = "../../.."

  tags   = var.tags
  name   = format("%s-main-rules", var.name)
  vpc_id = module.vpc.vpc_id
  rules = {
    https = {
      description              = "HTTPS"
      reciprocal_egress        = true
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
  }
}

output "security_group_main_rules" { value = module.security_group_main_rules }


module "security_group_mix_rules" {
  source = "../../.."

  tags   = var.tags
  name   = format("%s-mix-rules", var.name)
  vpc_id = module.vpc.vpc_id
  rules = {
    https = {
      description              = "HTTPS"
      reciprocal_egress        = true
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
  }
}

output "security_group_mix_rules" { value = module.security_group_mix_rules }

module "sg-rule-mix" {
  source = "../../../modules/basic_security_group_rule"

  from_port         = 80
  protocol          = "TCP"
  security_group_id = module.security_group_mix_rules.security-group.id
  to_port           = 80
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  reciprocal_egress = true
  description       = "Web access"
}
