resource "intersight_fabric_link_aggregation_policy" "default" {
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

  lacp_rate          = "normal"
  suspend_individual = true

}
