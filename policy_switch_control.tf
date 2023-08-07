resource "intersight_fabric_switch_control_policy" "default" {
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
}
