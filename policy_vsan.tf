resource "intersight_fabric_fc_network_policy" "default" {
  name = "default"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  enable_trunking = false

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

resource "intersight_fabric_vsan" "vsan1" {
  name = "vsan1"
  tags = [local.terraform]

  default_zoning = "Disabled"
  vsan_scope     = "Uplink"
  fcoe_vlan      = 11
  vsan_id        = 1

  fc_network_policy {
    moid = intersight_fabric_fc_network_policy.default.moid
  }

}
