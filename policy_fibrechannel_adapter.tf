resource "intersight_vnic_fc_adapter_policy" "default" {
  name = "default"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  error_detection_timeout     = 2000
  io_throttle_count           = 256
  lun_count                   = 1024
  lun_queue_depth             = 20
  resource_allocation_timeout = 10000

  error_recovery_settings {
    enabled = false
  }

  flogi_settings {
    retries = 8
    timeout = 4000
  }

  interrupt_settings {
    mode = "MSIx"
  }

  plogi_settings {
    retries = 8
    timeout = 20000
  }

  rx_queue_settings {
    nr_count  = 1
    ring_size = 64
  }

  scsi_queue_settings {
    nr_count  = 1
    ring_size = 512
  }

  tx_queue_settings {
    nr_count  = 1
    ring_size = 64
  }

}
