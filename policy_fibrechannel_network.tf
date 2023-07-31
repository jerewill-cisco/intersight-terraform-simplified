resource "intersight_vnic_fc_network_policy" "vsan1" {
  name = "vsan1"
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

  vsan_settings {
    id = 1
  }

}
