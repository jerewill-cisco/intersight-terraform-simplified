resource "intersight_fabric_flow_control_policy" "pfc" {
  name = "pfc"
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

  priority_flow_control_mode = "on"
  receive_direction          = "Disabled"
  send_direction             = "Disabled"

}

resource "intersight_fabric_flow_control_policy" "llfc" {
  name = "llfc"
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

  priority_flow_control_mode = "auto"
}
