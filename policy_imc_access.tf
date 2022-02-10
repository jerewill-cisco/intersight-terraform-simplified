resource "intersight_access_policy" "inband_imc" {
  name = "inband_imc"
  tags = [local.terraform]
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
  tags = [local.terraform]
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

  # This shouldn't really be necessary since configure_inband is false,
  # but if it's not configured then the Intersight API will return
  # a value of 4 for inband_vlan during subsequent plan operations
  # and TF will try to unset the value which will cause the apply fail.
  # https://github.com/CiscoDevNet/terraform-provider-intersight/issues/169
  inband_vlan = 4
  lifecycle {
    ignore_changes = [inband_vlan]
  }

}
