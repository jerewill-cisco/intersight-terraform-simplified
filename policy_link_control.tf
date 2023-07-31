resource "intersight_fabric_link_control_policy" "default" {
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

  udld_settings {
    admin_state = "Enabled"
    mode        = "normal"
  }

}
