# Basic usage with the Security Group rule submodule.

Basic quickstart example for creating a Security Group resource and some rules using the `basic_security_group_rule` submodule can be found in [`main.tf`](main.tf).

Example shows using Default Tags in the provider as well as passing additional tags into the resource.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
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
