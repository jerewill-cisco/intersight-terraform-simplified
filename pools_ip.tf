# We only have one IP pool today, but we expect to have more in the future.
# Because of that, we've chosen to create them from a variable and using a
# for_each because it will make it easy to add more pools for things like
# IKS or ICO or IWE when we are ready for them.

variable "ip_pools_map" {
  type = map(object({
    starting_address = string
    block_size       = number
    netmask          = string
    gateway_address  = string
    primary_dns      = string
    secondary_dns    = string
  }))
  default = {
    ucs_inband = {
      starting_address = "192.168.1.11"
      block_size       = 239
      netmask          = "255.255.255.0"
      gateway_address  = "192.168.1.1"
      primary_dns      = "10.0.0.10"
      secondary_dns    = "10.0.0.20"
    }
    ucs_outofband = {
      starting_address = "192.168.5.11"
      block_size       = 239
      netmask          = "255.255.255.0"
      gateway_address  = "192.168.5.1"
      primary_dns      = "10.0.0.10"
      secondary_dns    = "10.0.0.20"

    }
  }
}

resource "intersight_ippool_pool" "ip_pools" {
  for_each = var.ip_pools_map

  name = each.key
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  assignment_order = "sequential"

  ip_v4_blocks {
    from = each.value.starting_address
    size = each.value.block_size
  }

  ip_v4_config {
    gateway       = each.value.gateway_address
    netmask       = each.value.netmask
    primary_dns   = each.value.primary_dns
    secondary_dns = each.value.secondary_dns
  }

  lifecycle {
    ignore_changes = [ip_v4_blocks]
  }

}
