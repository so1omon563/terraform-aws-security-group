# frozen_string_literal: true

include_controls 'inspec-aws'

require './test/library/common'

tfstate = StateFileReader.new
sg_id = tfstate.read['outputs']['security_group']['value']['security-group']['id'].to_s
sg_id_main = tfstate.read['outputs']['security_group_main_rules']['value']['security-group']['id'].to_s
sg_id_mix = tfstate.read['outputs']['security_group_mix_rules']['value']['security-group']['id'].to_s
vpc_id = tfstate.read['outputs']['security_group']['value']['security-group']['vpc_id'].to_s

control 'default' do
  describe aws_security_group(sg_id) do
    it { should exist }
    it { should allow_in(port: 80, ipv4_range: '0.0.0.0/0', protocol: 'tcp') }
    it { should allow_out(port: 80, ipv4_range: '0.0.0.0/0', protocol: 'tcp') }
    it { should allow_in_only(port: 80, ipv4_range: '0.0.0.0/0', protocol: 'tcp') }
    it { should allow_out_only(port: 80, ipv4_range: '0.0.0.0/0', protocol: 'tcp') }
    its('group_name') { should cmp 'kitchen-sg' }
    its('inbound_rules_count') { should cmp 1 }
    its('outbound_rules_count') { should cmp 1 }
    its('description') { should cmp 'Security Group for kitchen-sg' }
    its('vpc_id') { should cmp vpc_id }
    its('tags') do
      should include 'Name' => 'kitchen-sg', 'environment' => 'dev', 'terraform' => 'true', 'kitchen' => 'true'
    end
  end

  describe aws_security_group(sg_id_main) do
    it { should exist }
    it { should allow_in(port: 443, ipv4_range: '0.0.0.0/0', protocol: 'tcp') }
    it { should allow_out(port: 443, ipv4_range: '0.0.0.0/0', protocol: 'tcp') }
    it { should allow_in_only(port: 443, ipv4_range: '0.0.0.0/0', protocol: 'tcp') }
    it { should allow_out_only(port: 443, ipv4_range: '0.0.0.0/0', protocol: 'tcp') }
    its('group_name') { should cmp 'kitchen-sg-main-rules' }
    its('inbound_rules_count') { should cmp 1 }
    its('outbound_rules_count') { should cmp 1 }
    its('description') { should cmp 'Security Group for kitchen-sg-main-rules' }
    its('vpc_id') { should cmp vpc_id }
    its('tags') do
      should include 'Name' => 'kitchen-sg-main-rules', 'environment' => 'dev', 'terraform' => 'true',
                     'kitchen' => 'true'
    end
  end

  describe aws_security_group(sg_id_mix) do
    it { should exist }
    it { should allow_in(port: 80, ipv4_range: '0.0.0.0/0', protocol: 'tcp') }
    it { should allow_out(port: 80, ipv4_range: '0.0.0.0/0', protocol: 'tcp') }
    it { should allow_in(port: 443, ipv4_range: '0.0.0.0/0', protocol: 'tcp') }
    it { should allow_out(port: 443, ipv4_range: '0.0.0.0/0', protocol: 'tcp') }
    its('group_name') { should cmp 'kitchen-sg-mix-rules' }
    its('inbound_rules_count') { should cmp 2 }
    its('outbound_rules_count') { should cmp 2 }
    its('description') { should cmp 'Security Group for kitchen-sg-mix-rules' }
    its('vpc_id') { should cmp vpc_id }
    its('tags') do
      should include 'Name' => 'kitchen-sg-mix-rules', 'environment' => 'dev', 'terraform' => 'true',
                     'kitchen' => 'true'
    end
  end
end
