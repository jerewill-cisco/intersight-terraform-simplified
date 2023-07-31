resource "intersight_fabric_eth_network_control_policy" "default" {
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

  cdp_enabled           = true
  forge_mac             = "allow"
  mac_registration_mode = "nativeVlanOnly"
  uplink_fail_action    = "linkDown"

  lldp_settings {
    receive_enabled  = true
    transmit_enabled = true
  }

}
