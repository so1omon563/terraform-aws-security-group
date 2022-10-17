# Basic Security Group Rule

A module to create an individual security group rule. Can be easily iterated across using `for_each`.
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
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.35.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group_rule.reciprocal_egress_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.reciprocal_egress_self_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.self_sg_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.sg_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_blocks"></a> [cidr\_blocks](#input\_cidr\_blocks) | List of CIDR blocks. Cannot be specified with `source_security_group_id`. | `list(string)` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the rule. | `string` | `null` | no |
| <a name="input_from_port"></a> [from\_port](#input\_from\_port) | Start port (or ICMP type number if protocol is 'icmp' or 'icmpv6'). | `string` | n/a | yes |
| <a name="input_ipv6_cidr_blocks"></a> [ipv6\_cidr\_blocks](#input\_ipv6\_cidr\_blocks) | List of IPv6 CIDR blocks. | `list(string)` | `null` | no |
| <a name="input_prefix_list_ids"></a> [prefix\_list\_ids](#input\_prefix\_list\_ids) | List of Prefix List IDs. | `list(string)` | `null` | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | Protocol. If not 'icmp', 'icmpv6', 'tcp', 'udp', or 'all' use the protocol number. | `string` | n/a | yes |
| <a name="input_reciprocal_egress"></a> [reciprocal\_egress](#input\_reciprocal\_egress) | Whether a matching egress rule will be created for an ingress rule. | `bool` | `false` | no |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | Security group to apply this rule to. | `string` | n/a | yes |
| <a name="input_self"></a> [self](#input\_self) | Whether the security group itself will be added as a source to this ingress rule. Cannot be specified with `source_security_group_id`. | `bool` | `false` | no |
| <a name="input_source_security_group_id"></a> [source\_security\_group\_id](#input\_source\_security\_group\_id) | Security group id to allow access to/from, depending on the type. Cannot be specified with `cidr_blocks` and `self`. | `string` | `null` | no |
| <a name="input_to_port"></a> [to\_port](#input\_to\_port) | End port (or ICMP code if protocol is 'icmp'). | `string` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | Type of rule being created. Valid options are ingress (inbound) or egress (outbound). | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_rule"></a> [security\_group\_rule](#output\_security\_group\_rule) | Collection of outputs for the security group rule |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
