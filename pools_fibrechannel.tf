###
###  Cisco suggests using WWNs OUI of 20:00:00:25:B5
###

# Note the difference between these two pools.  They are different types of names.
# It's easy to miss the WWPN vs WWNN.

resource "intersight_fcpool_pool" "cisco_af_2" {
  name = "cisco_af_2"
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

  pool_purpose = "WWNN"

  id_blocks {
    from = "20:00:00:25:B5:af:20:00"
    size = 1000
  }

  lifecycle {
    ignore_changes = [id_blocks]
  }

}

resource "intersight_fcpool_pool" "cisco_af_3" {
  name = "cisco_af_3"
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

  pool_purpose = "WWPN"

  id_blocks {
    from = "20:00:00:25:B5:af:30:00"
    size = 1000
  }

  lifecycle {
    ignore_changes = [id_blocks]
  }

}
