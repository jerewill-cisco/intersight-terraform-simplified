resource "intersight_ntp_policy" "disabled" {
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

  enabled  = false
  timezone = "Etc/GMT"
}

variable "ntp_map" {
  type = map(any)
  default = {
    us_eastern  = "America/New_York"
    us_central  = "America/Chicago"
    us_mountain = "America/Denver"
    us_pacific  = "America/Los_Angeles"
  }
}

# This resource is an example of using a simple map with a for_each loop.
# It creates four NTP policies in Intersight.  One for each element of the
# variable above.
resource "intersight_ntp_policy" "us_ntp" {
  for_each = var.ntp_map

  name = each.key
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
  ntp_servers = [
    "0.north-america.pool.ntp.org",
    "1.north-america.pool.ntp.org",
  ]
  timezone = each.value
}
