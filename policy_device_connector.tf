resource "intersight_deviceconnector_policy" "local_lockout" {
  name = "local_lockout"
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

  lockout_enabled = true
}

resource "intersight_deviceconnector_policy" "local_config_allowed" {
  name = "local_allowed"
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

  lockout_enabled = false
}
