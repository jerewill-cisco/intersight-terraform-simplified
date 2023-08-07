resource "intersight_fabric_system_qos_policy" "default" {
  name = "default"
  dynamic "tags" {
    for_each = local.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }
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
}
