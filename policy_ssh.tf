resource "intersight_ssh_policy" "disabled" {
  name = "disabled"
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

  enabled = false
}

resource "intersight_ssh_policy" "enabled" {
  name = "enabled"
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

  enabled = true
  port    = 22
  timeout = 1800
}


