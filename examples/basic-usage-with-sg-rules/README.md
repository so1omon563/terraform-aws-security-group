# Basic usage with the Security Group rules.

Basic quickstart example for creating a Security Group resource and some rules only using rules defined in the main module can be found in [`main.tf`](main.tf).

Example shows using Default Tags in the provider as well as passing additional tags into the resource.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_db-sg"></a> [db-sg](#module\_db-sg) | ../.. | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | so1omon563/vpc/aws | 1.0.0 |
| <a name="module_web-sg"></a> [web-sg](#module\_web-sg) | ../.. | n/a |

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
