# This policy is creates a very important policy for Intersight Managed Fabric Interconnects.
# While it's possible to have a very complex policy here, this TF code creates a simple configuration.

# This resource is the container where we assign port mode for each port.
# Each of the resources below are attached to this policy using a port_policy block.
resource "intersight_fabric_port_policy" "default-6454" {
  name = "default-6454"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  device_model = "UCS-FI-6454"

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

# The first 16 ports can be in FC mode, so we select how many of those interfaces we want to be FC.
# Update `port_id_end` to be the desired value.
resource "intersight_fabric_port_mode" "fibrechannel_ports" {
  custom_mode   = "FibreChannel"
  port_id_start = 1
  port_id_end   = 8 # <= Valid choices here are 4, 8, 12, 16
  slot_id       = 1

  port_policy {
    moid = intersight_fabric_port_policy.default-6454.moid
  }

}

# This resource configures each of the port in the range selected above to have the FC Uplink Role
# The range function here uses the start and end port numbers to generate the list of ports by referencing 
# the intersight_fabric_port_mode resource above.  Note the +1 is due to the range function not being inclusive in TF.
# We use the toset function to generate a set from the list so that we can use a for_each to create an 
# uplink_role object in the policy for each FC interface.
resource "intersight_fabric_fc_uplink_role" "fc_uplink_ports" {
  for_each = toset([for p in range(intersight_fabric_port_mode.fibrechannel_ports.port_id_start, intersight_fabric_port_mode.fibrechannel_ports.port_id_end + 1) : tostring(p)])

  port_id      = each.value
  slot_id      = 1
  admin_speed  = "32Gbps"
  fill_pattern = "Idle"
  vsan_id      = 1

  port_policy {
    moid = intersight_fabric_port_policy.default-6454.moid
  }

}

# Here we creating role objects for the remaining 25G interfaces.  We use the port_id_end +1 to get the first interface
# that should be Ethernet and configure the range of ports from there to port 48 by creating server_role objects for
# each of them.
resource "intersight_fabric_server_role" "server_ports" {
  for_each = toset([for p in range(intersight_fabric_port_mode.fibrechannel_ports.port_id_end + 1, 48 + 1) : tostring(p)])

  port_id = each.value
  slot_id = 1

  port_policy {
    moid = intersight_fabric_port_policy.default-6454.moid
  }

}

# It's certainly possible to confgiure 25g interfaces as Ethernet uplinks, but here we've chosen to use 100G interfaces.
# Here we just use a statically defined range of 49-54 to create uplink_role objects for each of them.  Note the +1
# is required because range is not inclusive in TF.
#configure the 100G interfaces as ethernet uplinks
resource "intersight_fabric_uplink_role" "ethernet_uplink_ports" {
  for_each = toset([for p in range(49, 54 + 1) : tostring(p)])

  port_id = each.value
  slot_id = 1

  port_policy {
    moid = intersight_fabric_port_policy.default-6454.moid
  }

}
