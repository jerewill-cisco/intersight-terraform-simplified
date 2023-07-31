resource "intersight_access_policy" "inband_imc" {
  name = "inband_imc"
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

  configuration_type {
    configure_inband      = true
    configure_out_of_band = false
  }

  inband_vlan = var.network_map_infra["inband_ucs"].vlan

  inband_ip_pool {
    moid = intersight_ippool_pool.ip_pools["ucs_inband"].id
  }

}

resource "intersight_access_policy" "outofband_imc" {
  name = "outofband_imc"
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

  configuration_type {
    configure_inband      = false
    configure_out_of_band = true
  }

  out_of_band_ip_pool {
    moid = intersight_ippool_pool.ip_pools["ucs_outofband"].id
  }

}
