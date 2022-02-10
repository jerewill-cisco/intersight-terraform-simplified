resource "intersight_ntp_policy" "disabled" {
  name = "disabled"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  enabled  = false
  timezone = "Etc/GMT"

  # This is a temporary workaround to the bug in intersight_fabric_switch_profile policy_bucket
  # we are attaching the profile to the policy here instead of attaching the policy to the profile in profile_ucs_domain.tf
  dynamic "profiles" {
    for_each = intersight_fabric_switch_profile.example
    content {
      moid        = profiles.value.moid
      object_type = profiles.value.object_type
    }
  }

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
  tags = [local.terraform]
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
