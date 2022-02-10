resource "intersight_fabric_switch_control_policy" "default" {
  name = "default"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  ethernet_switching_mode        = "end-host"
  fc_switching_mode              = "end-host"
  vlan_port_optimization_enabled = false

  mac_aging_settings {
    mac_aging_option = "Default"
  }

  udld_settings {
    message_interval = 15
    recovery_action  = "none"
  }

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
