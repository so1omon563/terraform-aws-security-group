# This file is for variables that may be required for the module to run.

variable "name" {
  type        = string
  description = "Short, descriptive name of the environment. All resources will be named using this value as a prefix."
}

variable "description" {
  description = "Description of the Security Group. If not provided, a default value based on `name` and `type` values will be used."
  type        = string
  default     = null
}

variable "revoke_rules" {
  type        = bool
  description = "Revoke any attached rules prior to Security Group deletion. Especially useful if rules are being attached in multiple modules."
  default     = true
}

variable "rules" {
  type = map(object({
    description              = string
    reciprocal_egress        = bool
    type                     = string
    from_port                = number
    to_port                  = number
    protocol                 = string
    cidr_blocks              = list(string)
    ipv6_cidr_blocks         = list(string)
    prefix_list_ids          = list(string)
    source_security_group_id = string
    self                     = bool
  }))
  description = <<EOT
  Optional method of creating Security Group Rules without using the separate submodule.
  Variable is a map of objects to add to the Security Group. Each object is a collection of key/value pair options for the Security Group.

  Each rule object must be named. The names are arbitrary, but will be reflected in the outputs. So, it is helpful for them to be descriptive.
  All values MUST be supplied, even if the value is `null`.
  For example:
  ```
  rules = {
      http = {
        description              = "HTTP for web"
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
        description              = "HTTPS for web"
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
  }
  ```
  Note that this calls the [`basic_security_group_rule`](modules/basic_security_group_rule) submodule to create the rules.

  Please see the [README](modules/basic_security_group_rule/README.md) for details about the options.
  Additional rules can be created by calling the submodule directly.
EOT
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "A map of tag names and values for tags to apply to all taggable resources created by the module. Default value is a blank map to allow for using Default Tags in the provider."
  default     = {}
}

variable "type" {
  description = "One word descriptive type - To be appended to the `name` variable to name the resources. Should be something descriptive like `app`, `db`, `alb`, etc."
  type        = string
  default     = null
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC these resources should be added to."
}
