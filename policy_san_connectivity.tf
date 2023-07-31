resource "intersight_vnic_san_connectivity_policy" "esxi" {
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

  placement_mode    = "auto"
  target_platform   = "FIAttached"
  wwnn_address_type = "POOL"

  wwnn_pool {
    moid = intersight_fcpool_pool.cisco_af_2.moid
  }

}

resource "intersight_vnic_fc_if" "fab_a_1" {
  name = "1_fab_a_1"
  dynamic "tags" {
    for_each = local.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }

  type              = "fc-initiator"
  order             = 0
  wwpn_address_type = "POOL"

  wwpn_pool {
    moid = intersight_fcpool_pool.cisco_af_3.moid
  }

  placement {
    switch_id = "A"
  }

  persistent_bindings = false

  fc_network_policy {
    moid = intersight_vnic_fc_network_policy.vsan1.moid
  }

  fc_qos_policy {
    moid = intersight_vnic_fc_qos_policy.default.moid
  }

  fc_adapter_policy {
    moid = intersight_vnic_fc_adapter_policy.default.moid
  }

  san_connectivity_policy {
    moid = intersight_vnic_san_connectivity_policy.esxi.moid
  }

}

resource "intersight_vnic_fc_if" "fab_a_2" {
  name = "2_fab_a_2"
  dynamic "tags" {
    for_each = local.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }

  type              = "fc-initiator"
  order             = 1
  wwpn_address_type = "POOL"

  wwpn_pool {
    moid = intersight_fcpool_pool.cisco_af_3.moid
  }

  placement {
    switch_id = "A"
  }

  persistent_bindings = false

  fc_network_policy {
    moid = intersight_vnic_fc_network_policy.vsan1.moid
  }

  fc_qos_policy {
    moid = intersight_vnic_fc_qos_policy.default.moid
  }

  fc_adapter_policy {
    moid = intersight_vnic_fc_adapter_policy.default.moid
  }

  san_connectivity_policy {
    moid = intersight_vnic_san_connectivity_policy.esxi.moid
  }

}

resource "intersight_vnic_fc_if" "fab_b_1" {
  name = "3_fab_b_1"
  dynamic "tags" {
    for_each = local.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }

  type              = "fc-initiator"
  order             = 2
  wwpn_address_type = "POOL"

  wwpn_pool {
    moid = intersight_fcpool_pool.cisco_af_3.moid
  }

  placement {
    switch_id = "B"
  }

  persistent_bindings = false

  fc_network_policy {
    moid = intersight_vnic_fc_network_policy.vsan1.moid
  }

  fc_qos_policy {
    moid = intersight_vnic_fc_qos_policy.default.moid
  }

  fc_adapter_policy {
    moid = intersight_vnic_fc_adapter_policy.default.moid
  }

  san_connectivity_policy {
    moid = intersight_vnic_san_connectivity_policy.esxi.moid
  }

}

resource "intersight_vnic_fc_if" "fab_b_2" {
  name = "1_fab_b_2"
  dynamic "tags" {
    for_each = local.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }

  type              = "fc-initiator"
  order             = 3
  wwpn_address_type = "POOL"

  wwpn_pool {
    moid = intersight_fcpool_pool.cisco_af_3.moid
  }

  placement {
    switch_id = "B"
  }

  persistent_bindings = false

  fc_network_policy {
    moid = intersight_vnic_fc_network_policy.vsan1.moid
  }

  fc_qos_policy {
    moid = intersight_vnic_fc_qos_policy.default.moid
  }

  fc_adapter_policy {
    moid = intersight_vnic_fc_adapter_policy.default.moid
  }

  san_connectivity_policy {
    moid = intersight_vnic_san_connectivity_policy.esxi.moid
  }

}
