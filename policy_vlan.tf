# This resource holds the configured VLANs for the Fabric Interconnect.
resource "intersight_fabric_eth_network_policy" "default" {
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
}

# The two resources below retrieve the list of VLANs from the two variables in variables_network.tf
# Each resource creates a number of fabric_vlan objects that are attached to the policy above.

resource "intersight_fabric_vlan" "vlans_infra" {
  for_each = var.network_map_infra

  name = each.key
  dynamic "tags" {
    for_each = local.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }


  auto_allow_on_uplinks = true
  is_native             = false
  vlan_id               = each.value.vlan

  eth_network_policy {
    moid = intersight_fabric_eth_network_policy.default.moid
  }

  multicast_policy {
    moid = intersight_fabric_multicast_policy.default.moid
  }

}

resource "intersight_fabric_vlan" "vlans_vmnetwork" {
  for_each = var.network_map_vmnetwork

  name = each.key
  dynamic "tags" {
    for_each = local.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }

  auto_allow_on_uplinks = true
  is_native             = false
  vlan_id               = each.value.vlan

  eth_network_policy {
    moid = intersight_fabric_eth_network_policy.default.moid
  }

  multicast_policy {
    moid = intersight_fabric_multicast_policy.default.moid
  }

}
