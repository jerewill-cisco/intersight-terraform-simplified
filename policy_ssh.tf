resource "intersight_ssh_policy" "disabled" {
  name = "disabled"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  enabled = false
}

resource "intersight_ssh_policy" "enabled" {
  name = "enabled"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  enabled = true
  port    = 22
  timeout = 1800
}


