resource "intersight_vnic_lan_connectivity_policy" "esxi" {
  name = "esxi"
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

  placement_mode  = "auto"
  target_platform = "FIAttached"
}

resource "intersight_vnic_eth_if" "mgmt_a" {
  name = "1_mgmt_a"
  dynamic "tags" {
    for_each = local.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }

  order            = 0
  mac_address_type = "POOL"

  mac_pool {
    moid = intersight_macpool_pool.cisco_af_1.moid
  }

  placement {
    switch_id = "A"
  }

  cdn {
    nr_source = "vnic"
  }

  fabric_eth_network_group_policy {
    moid = intersight_fabric_eth_network_group_policy.esxi_mgmt.moid
  }

  fabric_eth_network_control_policy {
    moid = intersight_fabric_eth_network_control_policy.default.moid
  }

  eth_qos_policy {
    moid = intersight_vnic_eth_qos_policy.default["silver"].moid
  }

  eth_adapter_policy {
    moid = intersight_vnic_eth_adapter_policy.esxi.moid
  }

  lifecycle {
    ignore_changes = [cdn]
  }

  lan_connectivity_policy {
    moid = intersight_vnic_lan_connectivity_policy.esxi.moid
  }

}

resource "intersight_vnic_eth_if" "mgmt_b" {
  name = "2_mgmt_b"
  dynamic "tags" {
    for_each = local.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }

  order            = 1
  mac_address_type = "POOL"

  mac_pool {
    moid = intersight_macpool_pool.cisco_af_1.moid
  }

  placement {
    switch_id = "B"
  }

  cdn {
    nr_source = "vnic"
  }

  fabric_eth_network_group_policy {
    moid = intersight_fabric_eth_network_group_policy.esxi_mgmt.moid
  }

  fabric_eth_network_control_policy {
    moid = intersight_fabric_eth_network_control_policy.default.moid
  }

  eth_qos_policy {
    moid = intersight_vnic_eth_qos_policy.default["silver"].moid
  }

  eth_adapter_policy {
    moid = intersight_vnic_eth_adapter_policy.esxi.moid
  }

  lifecycle {
    ignore_changes = [cdn]
  }

  lan_connectivity_policy {
    moid = intersight_vnic_lan_connectivity_policy.esxi.moid
  }

}

resource "intersight_vnic_eth_if" "vmotion_a" {
  name = "3_vmotion_a"
  dynamic "tags" {
    for_each = local.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }

  order            = 2
  mac_address_type = "POOL"

  mac_pool {
    moid = intersight_macpool_pool.cisco_af_1.moid
  }

  placement {
    switch_id = "A"
  }

  cdn {
    nr_source = "vnic"
  }

  fabric_eth_network_group_policy {
    moid = intersight_fabric_eth_network_group_policy.esxi_vmotion.moid
  }

  fabric_eth_network_control_policy {
    moid = intersight_fabric_eth_network_control_policy.default.moid
  }

  eth_qos_policy {
    moid = intersight_vnic_eth_qos_policy.default["bronze"].moid
  }

  eth_adapter_policy {
    moid = intersight_vnic_eth_adapter_policy.esxi.moid
  }

  lifecycle {
    ignore_changes = [cdn]
  }

  lan_connectivity_policy {
    moid = intersight_vnic_lan_connectivity_policy.esxi.moid
  }

}

resource "intersight_vnic_eth_if" "vmotion_b" {
  name = "4_vmotion_b"
  dynamic "tags" {
    for_each = local.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }

  order            = 3
  mac_address_type = "POOL"

  mac_pool {
    moid = intersight_macpool_pool.cisco_af_1.moid
  }

  placement {
    switch_id = "B"
  }

  cdn {
    nr_source = "vnic"
  }

  fabric_eth_network_group_policy {
    moid = intersight_fabric_eth_network_group_policy.esxi_vmotion.moid
  }

  fabric_eth_network_control_policy {
    moid = intersight_fabric_eth_network_control_policy.default.moid
  }

  eth_qos_policy {
    moid = intersight_vnic_eth_qos_policy.default["bronze"].moid
  }

  eth_adapter_policy {
    moid = intersight_vnic_eth_adapter_policy.esxi.moid
  }

  lifecycle {
    ignore_changes = [cdn]
  }

  lan_connectivity_policy {
    moid = intersight_vnic_lan_connectivity_policy.esxi.moid
  }

}

resource "intersight_vnic_eth_if" "iscsi_a" {
  name = "5_iscsi_a"
  dynamic "tags" {
    for_each = local.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }

  order            = 4
  mac_address_type = "POOL"

  mac_pool {
    moid = intersight_macpool_pool.cisco_af_1.moid
  }

  placement {
    switch_id = "A"
  }

  cdn {
    nr_source = "vnic"
  }

  fabric_eth_network_group_policy {
    moid = intersight_fabric_eth_network_group_policy.esxi_iscsi_a.moid
  }

  fabric_eth_network_control_policy {
    moid = intersight_fabric_eth_network_control_policy.default.moid
  }

  eth_qos_policy {
    moid = intersight_vnic_eth_qos_policy.default["bronze"].moid
  }

  eth_adapter_policy {
    moid = intersight_vnic_eth_adapter_policy.esxi.moid
  }

  lifecycle {
    ignore_changes = [cdn]
  }

  lan_connectivity_policy {
    moid = intersight_vnic_lan_connectivity_policy.esxi.moid
  }

}

resource "intersight_vnic_eth_if" "iscsi_b" {
  name = "6_iscsi_b"
  dynamic "tags" {
    for_each = local.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }

  order            = 5
  mac_address_type = "POOL"

  mac_pool {
    moid = intersight_macpool_pool.cisco_af_1.moid
  }

  placement {
    switch_id = "B"
  }

  cdn {
    nr_source = "vnic"
  }

  fabric_eth_network_group_policy {
    moid = intersight_fabric_eth_network_group_policy.esxi_iscsi_b.moid
  }

  fabric_eth_network_control_policy {
    moid = intersight_fabric_eth_network_control_policy.default.moid
  }

  eth_qos_policy {
    moid = intersight_vnic_eth_qos_policy.default["bronze"].moid
  }

  eth_adapter_policy {
    moid = intersight_vnic_eth_adapter_policy.esxi.moid
  }

  lifecycle {
    ignore_changes = [cdn]
  }

  lan_connectivity_policy {
    moid = intersight_vnic_lan_connectivity_policy.esxi.moid
  }

}

resource "intersight_vnic_eth_if" "vmnetworks_a" {
  name = "7_vmnetworks_a"
  dynamic "tags" {
    for_each = local.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }

  order            = 6
  mac_address_type = "POOL"

  mac_pool {
    moid = intersight_macpool_pool.cisco_af_1.moid
  }

  placement {
    switch_id = "A"
  }

  cdn {
    nr_source = "vnic"
  }

  fabric_eth_network_group_policy {
    moid = intersight_fabric_eth_network_group_policy.esxi_vmnetworks.moid
  }

  fabric_eth_network_control_policy {
    moid = intersight_fabric_eth_network_control_policy.default.moid
  }

  eth_qos_policy {
    moid = intersight_vnic_eth_qos_policy.default["gold"].moid
  }

  eth_adapter_policy {
    moid = intersight_vnic_eth_adapter_policy.esxi.moid
  }

  lifecycle {
    ignore_changes = [cdn]
  }

  lan_connectivity_policy {
    moid = intersight_vnic_lan_connectivity_policy.esxi.moid
  }

}

resource "intersight_vnic_eth_if" "vmnetworks_b" {
  name = "8_vmnetworks_b"
  dynamic "tags" {
    for_each = local.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }

  order            = 7
  mac_address_type = "POOL"

  mac_pool {
    moid = intersight_macpool_pool.cisco_af_1.moid
  }

  placement {
    switch_id = "B"
  }

  cdn {
    nr_source = "vnic"
  }

  fabric_eth_network_group_policy {
    moid = intersight_fabric_eth_network_group_policy.esxi_vmnetworks.moid
  }

  fabric_eth_network_control_policy {
    moid = intersight_fabric_eth_network_control_policy.default.moid
  }

  eth_qos_policy {
    moid = intersight_vnic_eth_qos_policy.default["gold"].moid
  }

  eth_adapter_policy {
    moid = intersight_vnic_eth_adapter_policy.esxi.moid
  }

  lifecycle {
    ignore_changes = [cdn]
  }

  lan_connectivity_policy {
    moid = intersight_vnic_lan_connectivity_policy.esxi.moid
  }

}

resource "intersight_vnic_lan_connectivity_policy" "standalone" {
  name = "standalone"
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

  #  placement_mode  = "auto"
  target_platform = "Standalone"
}

resource "intersight_vnic_eth_if" "standalone_eth0" {
  name = "eth0"
  dynamic "tags" {
    for_each = local.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }

  order            = 0
  mac_address_type = "POOL"

  mac_pool {
    moid = intersight_macpool_pool.cisco_af_1.moid
  }

  placement {
    id     = "MLOM"
    uplink = "0"
  }

  cdn {
    nr_source = "vnic"
  }

  eth_network_policy {
    moid = intersight_vnic_eth_network_policy.access_mode.moid
  }

  eth_qos_policy {
    moid = intersight_vnic_eth_qos_policy.default["gold"].moid
  }

  eth_adapter_policy {
    moid = intersight_vnic_eth_adapter_policy.esxi.moid
  }

  lifecycle {
    ignore_changes = [cdn]
  }

  lan_connectivity_policy {
    moid = intersight_vnic_lan_connectivity_policy.standalone.moid
  }

}

resource "intersight_vnic_eth_if" "standalone_eth1" {
  name = "eth1"
  dynamic "tags" {
    for_each = local.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }

  order            = 1
  mac_address_type = "POOL"

  mac_pool {
    moid = intersight_macpool_pool.cisco_af_1.moid
  }

  placement {
    id     = "MLOM"
    uplink = "1"
  }

  cdn {
    nr_source = "vnic"
  }

  eth_network_policy {
    moid = intersight_vnic_eth_network_policy.access_mode.moid
  }

  eth_qos_policy {
    moid = intersight_vnic_eth_qos_policy.default["gold"].moid
  }

  eth_adapter_policy {
    moid = intersight_vnic_eth_adapter_policy.esxi.moid
  }

  lifecycle {
    ignore_changes = [cdn]
  }

  lan_connectivity_policy {
    moid = intersight_vnic_lan_connectivity_policy.standalone.moid
  }

}


resource "intersight_vnic_eth_if" "standalone_eth2" {
  name = "eth2"
  dynamic "tags" {
    for_each = local.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }

  order            = 2
  mac_address_type = "POOL"

  mac_pool {
    moid = intersight_macpool_pool.cisco_af_1.moid
  }

  placement {
    id     = "MLOM"
    uplink = "2"
  }

  cdn {
    nr_source = "vnic"
  }

  eth_network_policy {
    moid = intersight_vnic_eth_network_policy.access_mode.moid
  }

  eth_qos_policy {
    moid = intersight_vnic_eth_qos_policy.default["gold"].moid
  }

  eth_adapter_policy {
    moid = intersight_vnic_eth_adapter_policy.esxi.moid
  }

  lifecycle {
    ignore_changes = [cdn]
  }

  lan_connectivity_policy {
    moid = intersight_vnic_lan_connectivity_policy.standalone.moid
  }

}


resource "intersight_vnic_eth_if" "standalone_eth3" {
  name = "eth3"
  dynamic "tags" {
    for_each = local.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }

  order            = 3
  mac_address_type = "POOL"

  mac_pool {
    moid = intersight_macpool_pool.cisco_af_1.moid
  }

  placement {
    id     = "MLOM"
    uplink = "3"
  }

  cdn {
    nr_source = "vnic"
  }

  eth_network_policy {
    moid = intersight_vnic_eth_network_policy.access_mode.moid
  }

  eth_qos_policy {
    moid = intersight_vnic_eth_qos_policy.default["gold"].moid
  }

  eth_adapter_policy {
    moid = intersight_vnic_eth_adapter_policy.esxi.moid
  }

  lifecycle {
    ignore_changes = [cdn]
  }

  lan_connectivity_policy {
    moid = intersight_vnic_lan_connectivity_policy.standalone.moid
  }

}
