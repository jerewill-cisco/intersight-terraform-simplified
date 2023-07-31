variable "qos_map" {
  type = map(object({
    mtu   = number
    cos   = number
    class = string
  }))
  default = {
    platinum = {
      mtu   = 1500
      cos   = 5
      class = "Platinum"
    }
    gold = {
      mtu   = 1500
      cos   = 4
      class = "Gold"
    }
    silver = {
      mtu   = 1500
      cos   = 2
      class = "Silver"
    }
    bronze = {
      mtu   = 9000
      cos   = 1
      class = "Bronze"
    }
    be = {
      mtu   = 1500
      cos   = 0
      class = "Best Effort"
    }
  }
}

# This resource uses the above variable to create a set of policies.
# Each object above becomes a different Ethernet QoS Policy in Intersight.

resource "intersight_vnic_eth_qos_policy" "default" {
  for_each = var.qos_map

  name = each.key
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

  mtu            = each.value.mtu
  rate_limit     = 0
  cos            = each.value.cos
  burst          = 10240
  priority       = each.value.class
  trust_host_cos = false
}
