resource "intersight_sol_policy" "com0_9600baud" {
  name = "com0_9600baud"
  tags = [local.terraform]
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
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  enabled = false
}
