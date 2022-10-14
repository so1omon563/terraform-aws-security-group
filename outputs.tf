locals {
  // list of attributes to filter from output variables
  output_filter = ["assume_role_policy", "description", "egress", "ingress", "policy", "tags", "value"]
}

output "security-group" {
  value       = { for k, v in aws_security_group.security_group : k => v if !contains(local.output_filter, k) }
  description = "Collection of outputs for the security group"
}

output "sg-rules" {
  value       = module.sg-rules
  description = "Collection of outputs for any security group rules that are created by this module."
}
