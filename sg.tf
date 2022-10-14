resource "aws_security_group" "security_group" {
  #checkov:skip=CKV2_AWS_5:The module is used to create the security groups that will later be attached. This is by design.
  name                   = var.type == null ? format("%s", var.name) : format("%s-%s", var.name, var.type)
  description            = var.description == null ? var.type == null ? "Security Group for ${format("%s", var.name)}" : "Security Group for ${format("%s-%s", var.name, var.type)}" : var.description
  vpc_id                 = var.vpc_id
  revoke_rules_on_delete = var.revoke_rules

  tags = var.type == null ? merge({ "Name" = format("%s", var.name) }, local.tags) : merge({ "Name" = format("%s-%s", var.name, var.type) }, local.tags)
}
