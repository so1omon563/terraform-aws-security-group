resource "aws_security_group_rule" "sg_rule" {
  count                    = var.self == false ? 1 : 0
  description              = var.description
  type                     = var.type
  from_port                = var.from_port
  to_port                  = var.to_port
  protocol                 = var.protocol
  ipv6_cidr_blocks         = var.ipv6_cidr_blocks
  security_group_id        = var.security_group_id
  source_security_group_id = var.source_security_group_id
  #tfsec:ignore:AWS006 - This needs to be able to be publicly exposed by design.
  #tfsec:ignore:AWS007 - This needs to be able to be publicly exposed by design.
  cidr_blocks     = var.cidr_blocks
  prefix_list_ids = var.prefix_list_ids
}

resource "aws_security_group_rule" "reciprocal_egress_rule" {
  count                    = var.self == false && var.reciprocal_egress == true && var.type == "ingress" ? 1 : 0
  description              = var.description
  type                     = "egress"
  from_port                = var.from_port
  to_port                  = var.to_port
  protocol                 = var.protocol
  ipv6_cidr_blocks         = var.ipv6_cidr_blocks
  security_group_id        = var.security_group_id
  source_security_group_id = var.source_security_group_id
  #tfsec:ignore:AWS006 - This needs to be able to be publicly exposed by design.
  #tfsec:ignore:AWS007 - This needs to be able to be publicly exposed by design.
  cidr_blocks     = var.cidr_blocks
  prefix_list_ids = var.prefix_list_ids
}

resource "aws_security_group_rule" "self_sg_rule" {
  count             = var.self == true ? 1 : 0
  description       = var.description
  type              = var.type
  from_port         = var.from_port
  to_port           = var.to_port
  protocol          = var.protocol
  ipv6_cidr_blocks  = var.ipv6_cidr_blocks
  security_group_id = var.security_group_id
  self              = var.self
  prefix_list_ids   = var.prefix_list_ids
}

resource "aws_security_group_rule" "reciprocal_egress_self_rule" {
  count             = var.self == true && var.reciprocal_egress == true && var.type == "ingress" ? 1 : 0
  description       = var.description
  type              = "egress"
  from_port         = var.from_port
  to_port           = var.to_port
  protocol          = var.protocol
  ipv6_cidr_blocks  = var.ipv6_cidr_blocks
  security_group_id = var.security_group_id
  self              = var.self
  prefix_list_ids   = var.prefix_list_ids
}
