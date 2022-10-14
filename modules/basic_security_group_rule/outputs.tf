output "security_group_rule" {
  value       = { for k, v in aws_security_group_rule.sg_rule : k => v }
  description = "Collection of outputs for the security group rule"
}
