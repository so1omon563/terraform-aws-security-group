# This file is for variables that may be required for the module to run.

variable "description" {
  type        = string
  description = "Description of the rule."
  default     = null
}
variable "reciprocal_egress" {
  type        = bool
  description = "Whether a matching egress rule will be created for an ingress rule."
  default     = false
}

variable "type" {
  type        = string
  description = "Type of rule being created. Valid options are ingress (inbound) or egress (outbound)."
  validation {
    condition = contains([
      "ingress",
      "egress",
    ], var.type)
    error_message = "Valid option are limited to (ingress, egress)."
  }
}

variable "from_port" {
  type        = string
  description = "Start port (or ICMP type number if protocol is 'icmp' or 'icmpv6')."
}

variable "to_port" {
  type        = string
  description = "End port (or ICMP code if protocol is 'icmp')."
}

variable "protocol" {
  type        = string
  description = "Protocol. If not 'icmp', 'icmpv6', 'tcp', 'udp', or 'all' use the protocol number."
}

variable "security_group_id" {
  type        = string
  description = "Security group to apply this rule to."
}

variable "cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks. Cannot be specified with `source_security_group_id`."
  default     = null
}

variable "ipv6_cidr_blocks" {
  type        = list(string)
  description = "List of IPv6 CIDR blocks."
  default     = null
}

variable "prefix_list_ids" {
  type        = list(string)
  description = "List of Prefix List IDs."
  default     = null
}

variable "source_security_group_id" {
  type        = string
  description = "Security group id to allow access to/from, depending on the type. Cannot be specified with `cidr_blocks` and `self`."
  default     = null
}

variable "self" {
  type        = bool
  description = "Whether the security group itself will be added as a source to this ingress rule. Cannot be specified with `source_security_group_id`."
  default     = false
}
