##
##  Cisco suggests using MAC OUI of 00:25:B5
##

# This is a perfectly reasonable MAC pool.  It's important to verify that the addresses in this pool
# are not configured in any other UCS Manager systems in the same environment.  MAC addresses really
# should be globally unique in your infrastructure.
resource "intersight_macpool_pool" "cisco_af_1" {
  name = "cisco_af_1"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  mac_blocks {
    from = "00:25:B5:AF:10:00"
    size = 1000
  }

  lifecycle {
    ignore_changes = [mac_blocks]
  }

}

# Perhaps you want a MUCH larger MAC pool because you are using one Intersight instance to configure
# a large number of servers at many sites.  This resource uses a dynamic block to add 16 pools to the
# policy with 1000 addresses in each block.
resource "intersight_macpool_pool" "cisco_0F" {
  name = "cisco_0f"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }
  
  dynamic "mac_blocks" {
    for_each = formatlist("%X", range(0, 16))
    content {
      from = "00:25:B5:0F:${mac_blocks.value}0:00"
      size = 1000
    }
  }

  lifecycle {
    ignore_changes = [mac_blocks]
  }

}
