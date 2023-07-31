resource "intersight_fabric_multicast_policy" "default" {
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

  snooping_state = "Enabled"
  querier_state  = "Disabled"
}
