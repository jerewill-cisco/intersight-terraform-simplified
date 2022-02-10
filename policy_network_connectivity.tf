# This resource has a problem.  Intersight returns a value
# for the IPv6 name server even when IPv6 is disabled.
# This causes the resoruce to appear to need to be changed
# on every run.
# https://github.com/CiscoDevNet/terraform-provider-intersight/issues/104

resource "intersight_networkconfig_policy" "default" {
  name = "default"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  enable_dynamic_dns = false

  # ipv4
  enable_ipv4dns_from_dhcp = false
  preferred_ipv4dns_server = "10.10.10.1"
  alternate_ipv4dns_server = "10.10.10.2"

  # ipv6
  enable_ipv6              = false
  enable_ipv6dns_from_dhcp = false

  # This is a temporary workaround to the bug in intersight_fabric_switch_profile policy_bucket
  # we are attaching the profile to the policy here instead of attaching the policy to the profile in profile_ucs_domain.tf
  dynamic "profiles" {
    for_each = intersight_fabric_switch_profile.example
    content {
      moid        = profiles.value.moid
      object_type = profiles.value.object_type
    }
  }

}
