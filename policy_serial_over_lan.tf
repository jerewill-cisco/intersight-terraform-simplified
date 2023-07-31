resource "intersight_sol_policy" "com0_9600baud" {
  name = "com0_9600baud"
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

  enabled   = true
  baud_rate = 9600
  com_port  = "com0"
  ssh_port  = 2400
}

resource "intersight_sol_policy" "disabled" {
  name = "disabled"
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

  enabled = false
}
