#
# High Power, Maximum Power and Acoustic modes are 
# only supported for Cisco UCS X series Chassis
#

# This resource creates a thermal policy for each value of the list that is statically specified
# The name of each policy is converted to all lower case using the lower function to match our
# chosen naming standard in Intersight
resource "intersight_thermal_policy" "thermal" {
  for_each = toset(["Balanced", "LowPower", "HighPower", "MaximumPower", "Acoustic"])

  name = lower(each.key)
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

  fan_control_mode = each.key
}
