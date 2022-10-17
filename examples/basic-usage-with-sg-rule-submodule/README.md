# Basic usage with the Security Group rule submodule

Basic quickstart example for creating a Security Group resource and some rules using the `basic_security_group_rule` submodule.

Example shows using Default Tags in the provider as well as passing additional tags into the resource.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->



## Examples

```hcl
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
```

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_db-egress-ephemeral"></a> [db-egress-ephemeral](#module\_db-egress-ephemeral) | so1omon563/security-group/aws//modules/basic_security_group_rule | 1.0.0 |
| <a name="module_db-self"></a> [db-self](#module\_db-self) | so1omon563/security-group/aws//modules/basic_security_group_rule | 1.0.0 |
| <a name="module_db-sg"></a> [db-sg](#module\_db-sg) | so1omon563/security-group/aws | 1.0.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | so1omon563/vpc/aws | 1.0.0 |
| <a name="module_web-egress-ephemeral"></a> [web-egress-ephemeral](#module\_web-egress-ephemeral) | so1omon563/security-group/aws//modules/basic_security_group_rule | 1.0.0 |
| <a name="module_web-rules"></a> [web-rules](#module\_web-rules) | so1omon563/security-group/aws//modules/basic_security_group_rule | 1.0.0 |
| <a name="module_web-self"></a> [web-self](#module\_web-self) | so1omon563/security-group/aws//modules/basic_security_group_rule | 1.0.0 |
| <a name="module_web-sg"></a> [web-sg](#module\_web-sg) | so1omon563/security-group/aws | 1.0.0 |
| <a name="module_web-to-db"></a> [web-to-db](#module\_web-to-db) | so1omon563/security-group/aws//modules/basic_security_group_rule | 1.0.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"example-sg"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | <pre>{<br>  "example": "true"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db-sg"></a> [db-sg](#output\_db-sg) | n/a |
| <a name="output_web-sg"></a> [web-sg](#output\_web-sg) | n/a |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
