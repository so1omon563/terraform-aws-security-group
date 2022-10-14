module "sg-rules" {
  for_each = var.rules
  source   = "./modules/basic_security_group_rule"

  description              = each.value.description
  reciprocal_egress        = each.value.reciprocal_egress
  type                     = each.value.type
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  security_group_id        = aws_security_group.security_group.id
  cidr_blocks              = each.value.cidr_blocks
  ipv6_cidr_blocks         = each.value.ipv6_cidr_blocks
  prefix_list_ids          = each.value.prefix_list_ids
  source_security_group_id = each.value.source_security_group_id

}
