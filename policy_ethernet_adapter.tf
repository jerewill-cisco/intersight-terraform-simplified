##
## Ethernet Adapter Policy Guidance
##
## These settings can be pretty complex and have a significant impact on network performance.
## For more guidance, please see the performance tuning whitepaper.
## https://www.cisco.com/c/en/us/products/collateral/interfaces-modules/unified-computing-system-adapters/victuning-wp.html
##


resource "intersight_vnic_eth_adapter_policy" "esxi" {
  name = "esxi"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  advanced_filter         = false
  interrupt_scaling       = false
  rss_settings            = false
  uplink_failback_timeout = 5

  interrupt_settings {
    coalescing_time = 125
    coalescing_type = "MIN"
    nr_count        = 8
    mode            = "MSIx"
  }

  rss_hash_settings {
    ipv4_hash         = true
    ipv6_hash         = true
    ipv6_ext_hash     = false
    tcp_ipv4_hash     = true
    tcp_ipv6_ext_hash = false
    tcp_ipv6_hash     = true
    udp_ipv4_hash     = false
    udp_ipv6_hash     = false
  }

  completion_queue_settings {
    nr_count  = 2
    ring_size = 1
  }

  rx_queue_settings {
    nr_count  = 1
    ring_size = 512
  }

  tx_queue_settings {
    nr_count  = 1
    ring_size = 256
  }

  tcp_offload_settings {
    large_receive = true
    large_send    = true
    rx_checksum   = true
    tx_checksum   = true
  }
  arfs_settings {
    enabled = false
  }

  vxlan_settings {
    enabled = false
  }

  nvgre_settings {
    enabled = false
  }

  roce_settings {
    enabled         = false
    memory_regions  = 0
    queue_pairs     = 0
    resource_groups = 0
  }

}
