# Security Group

A module to create a security group. Please note that this creates no rules. Rules can be created by passing in values to the `rules` variable, or by using sub-modules in the [modules](modules) directory.

Examples for use can be found under the [examples](examples) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

Auto-generated technical documentation is created using [`terraform-docs`](https://terraform-docs.io/)

## Examples

```hcl
# See examples under the top level examples directory for more information on how to use this module.
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.21 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.34.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sg-rules"></a> [sg-rules](#module\_sg-rules) | ./modules/basic_security_group_rule | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description of the Security Group. If not provided, a default value based on `name` and `type` values will be used. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Short, descriptive name of the environment. All resources will be named using this value as a prefix. | `string` | n/a | yes |
| <a name="input_revoke_rules"></a> [revoke\_rules](#input\_revoke\_rules) | Revoke any attached rules prior to Security Group deletion. Especially useful if rules are being attached in multiple modules. | `bool` | `true` | no |
| <a name="input_rules"></a> [rules](#input\_rules) | Optional method of creating Security Group Rules without using the separate submodule.<br>  Variable is a map of objects to add to the Security Group. Each object is a collection of key/value pair options for the Security Group.<br><br>  Each rule object must be named. The names are arbitrary, but will be reflected in the outputs. So, it is helpful for them to be descriptive.<br>  All values MUST be supplied, even if the value is `null`.<br>  For example:<pre>rules = {<br>      http = {<br>        description              = "HTTP for web"<br>        reciprocal_egress        = false<br>        type                     = "ingress"<br>        from_port                = 80<br>        to_port                  = 80<br>        protocol                 = "TCP"<br>        cidr_blocks              = ["0.0.0.0/0"]<br>        self                     = false<br>        ipv6_cidr_blocks         = null<br>        prefix_list_ids          = null<br>        source_security_group_id = null<br>    }<br>      https = {<br>        description              = "HTTPS for web"<br>        reciprocal_egress        = false<br>        type                     = "ingress"<br>        from_port                = 443<br>        to_port                  = 443<br>        protocol                 = "TCP"<br>        cidr_blocks              = ["0.0.0.0/0"]<br>        self                     = false<br>        ipv6_cidr_blocks         = null<br>        prefix_list_ids          = null<br>        source_security_group_id = null<br>    }<br>  }</pre>Note that this calls the [`basic_security_group_rule`](modules/basic\_security\_group\_rule) submodule to create the rules.<br><br>  Please see the [README](modules/basic\_security\_group\_rule/README.md) for details about the options.<br>  Additional rules can be created by calling the submodule directly. | <pre>map(object({<br>    description              = string<br>    reciprocal_egress        = bool<br>    type                     = string<br>    from_port                = number<br>    to_port                  = number<br>    protocol                 = string<br>    cidr_blocks              = list(string)<br>    ipv6_cidr_blocks         = list(string)<br>    prefix_list_ids          = list(string)<br>    source_security_group_id = string<br>    self                     = bool<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tag names and values for tags to apply to all taggable resources created by the module. Default value is a blank map to allow for using Default Tags in the provider. | `map(string)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | One word descriptive type - To be appended to the `name` variable to name the resources. Should be something descriptive like `app`, `db`, `alb`, etc. | `string` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC these resources should be added to. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security-group"></a> [security-group](#output\_security-group) | Collection of outputs for the security group |
| <a name="output_sg-rules"></a> [sg-rules](#output\_sg-rules) | Collection of outputs for any security group rules that are created by this module. |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
