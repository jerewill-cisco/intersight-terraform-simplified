##
## This file references two variables that are defined in variables_network.tf
##

resource "intersight_fabric_eth_network_group_policy" "esxi_mgmt" {
  name = "esxi_mgmt"
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

  vlan_settings {
    native_vlan   = var.network_map_infra["inband_vmware"].vlan
    allowed_vlans = var.network_map_infra["inband_vmware"].vlan
  }

}

resource "intersight_fabric_eth_network_group_policy" "esxi_vmotion" {
  name = "esxi_vmotion"
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

  vlan_settings {
    native_vlan   = var.network_map_infra["vmotion"].vlan
    allowed_vlans = var.network_map_infra["vmotion"].vlan
  }

}

resource "intersight_fabric_eth_network_group_policy" "esxi_iscsi_a" {
  name = "esxi_iscsi_a"
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

  vlan_settings {
    native_vlan   = var.network_map_infra["iscsi_a"].vlan
    allowed_vlans = var.network_map_infra["iscsi_a"].vlan
  }

}
resource "intersight_fabric_eth_network_group_policy" "esxi_iscsi_b" {
  name = "esxi_iscsi_b"
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

  vlan_settings {
    native_vlan   = var.network_map_infra["iscsi_b"].vlan
    allowed_vlans = var.network_map_infra["iscsi_b"].vlan
  }

}

resource "intersight_fabric_eth_network_group_policy" "esxi_vmnetworks" {
  name = "esxi_vmnetworks"
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

  vlan_settings {
    native_vlan = 1
    # The for expression extracts all of the vlan values from the
    # objects in the variable and puts them into a list.
    # The join function then takes the VLAN ID list and combines 
    # them into a string, in this  a comma separated one.
    allowed_vlans = join(",", [for e in var.network_map_vmnetwork : e.vlan])
  }

}

resource "intersight_fabric_eth_network_group_policy" "all" {
  name = "all"
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

  vlan_settings {
    native_vlan   = 1
    allowed_vlans = format("%s,%s", join(",", [for e in var.network_map_vmnetwork : e.vlan]), join(",", [for e in var.network_map_infra : e.vlan]))
  }

}

