resource "intersight_fabric_fc_network_policy" "default" {
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

  enable_trunking = false
}

resource "intersight_fabric_vsan" "vsan1" {
  name = "vsan1"
  dynamic "tags" {
    for_each = local.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }

  default_zoning = "Disabled"
  vsan_scope     = "Uplink"
  fcoe_vlan      = 11
  vsan_id        = 1

  fc_network_policy {
    moid = intersight_fabric_fc_network_policy.default.moid
  }

}
