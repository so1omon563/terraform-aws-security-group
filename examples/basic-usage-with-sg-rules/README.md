# Basic usage with the Security Group rules

Basic quickstart example for creating a Security Group resource and some rules only using rules defined in the main module.

Example shows using Default Tags in the provider as well as passing additional tags into the resource.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->



## Examples

```hcl
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
```

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_db-sg"></a> [db-sg](#module\_db-sg) | so1omon563/security-group/aws | 1.0.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | so1omon563/vpc/aws | 1.0.0 |
| <a name="module_web-sg"></a> [web-sg](#module\_web-sg) | so1omon563/security-group/aws | 1.0.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"example-sg-main"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | <pre>{<br>  "example": "true"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db-sg"></a> [db-sg](#output\_db-sg) | n/a |
| <a name="output_web-sg"></a> [web-sg](#output\_web-sg) | n/a |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
