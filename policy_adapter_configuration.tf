resource "intersight_adapter_config_policy" "mlom_no_pc" {
  name = "mlom_no_pc"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  settings {
    object_type = "adapter.AdapterConfig"
    slot_id     = "MLOM"

    eth_settings {
      object_type  = "adapter.EthSettings"
      lldp_enabled = true
    }

    fc_settings {
      object_type = "adapter.FcSettings"
      fip_enabled = true
    }

    port_channel_settings {
      object_type = "adapter.PortChannelSettings"
      enabled     = false
    }

    dynamic "dce_interface_settings" {
      for_each = range(4)
      content {
        object_type = "adapter.DceInterfaceSettings"
        interface_id = dce_interface_settings.value
        fec_mode = "Off"
      }
    }
  }
}
