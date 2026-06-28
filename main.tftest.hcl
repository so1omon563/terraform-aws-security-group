mock_provider "aws" {}

run "default_security_group" {
  command = plan

  variables {
    name   = "example"
    vpc_id = "vpc-1234567890abcdef0"
  }

  assert {
    condition     = aws_security_group.security_group.name == "example"
    error_message = "Expected the security group name to match var.name."
  }

  assert {
    condition     = aws_security_group.security_group.description == "Security Group for example"
    error_message = "Expected the default description to use var.name."
  }

  assert {
    condition     = aws_security_group.security_group.revoke_rules_on_delete == true
    error_message = "Expected revoke_rules_on_delete to default to true."
  }

  assert {
    condition     = aws_security_group.security_group.tags.Name == "example"
    error_message = "Expected the Name tag to match the security group name."
  }
}

run "typed_security_group" {
  command = plan

  variables {
    name   = "example"
    type   = "web"
    vpc_id = "vpc-1234567890abcdef0"
  }

  assert {
    condition     = aws_security_group.security_group.name == "example-web"
    error_message = "Expected the security group name to include var.type."
  }

  assert {
    condition     = aws_security_group.security_group.description == "Security Group for example-web"
    error_message = "Expected the default description to include var.type."
  }
}

run "security_group_rules" {
  command = plan

  variables {
    name   = "example"
    type   = "web"
    vpc_id = "vpc-1234567890abcdef0"

    rules = {
      http = {
        description              = "HTTP"
        reciprocal_egress        = true
        type                     = "ingress"
        from_port                = 80
        to_port                  = 80
        protocol                 = "tcp"
        cidr_blocks              = ["10.0.0.0/8"]
        ipv6_cidr_blocks         = null
        prefix_list_ids          = null
        source_security_group_id = null
        self                     = false
      }
    }
  }

  assert {
    condition     = length(module.sg-rules) == 1
    error_message = "Expected one security group rule module instance."
  }
}
