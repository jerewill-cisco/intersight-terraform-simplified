resource "intersight_smtp_policy" "disabled" {
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

resource "intersight_smtp_policy" "example" {
  name = "example"
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

  smtp_port       = 25
  min_severity    = "major"
  smtp_server     = "smtp.example.com"
  sender_email    = "notifications@example.com"
  smtp_recipients = ["ucs-operations-team@example.com"]
}
