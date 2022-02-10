resource "intersight_fabric_system_qos_policy" "default" {
  name = "default"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  classes {
    admin_state        = "Enabled"
    bandwidth_percent  = 6
    cos                = 1
    mtu                = 9000
    multicast_optimize = false
    name               = "Bronze"
    packet_drop        = true
    weight             = 1
  }

  classes {
    admin_state        = "Enabled"
    bandwidth_percent  = 6
    cos                = 2
    mtu                = 1500
    multicast_optimize = true
    name               = "Silver"
    packet_drop        = true
    weight             = 1
  }

  classes {
    admin_state        = "Enabled"
    bandwidth_percent  = 25
    cos                = 4
    mtu                = 1500
    multicast_optimize = false
    name               = "Gold"
    packet_drop        = true
    weight             = 4
  }

  classes {
    admin_state        = "Enabled"
    bandwidth_percent  = 25
    cos                = 5
    mtu                = 1500
    multicast_optimize = false
    name               = "Platinum"
    packet_drop        = false
    weight             = 4
  }

  classes {
    admin_state        = "Enabled"
    bandwidth_percent  = 6
    cos                = 255
    mtu                = 1500
    multicast_optimize = false
    name               = "Best Effort"
    packet_drop        = true
    weight             = 1
  }

  classes {
    admin_state        = "Enabled"
    bandwidth_percent  = 32
    cos                = 3
    mtu                = 2240
    multicast_optimize = false
    name               = "FC"
    packet_drop        = false
    weight             = 5
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
