resource "intersight_deviceconnector_policy" "local_lockout" {
  name = "local_lockout"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  lockout_enabled = true
}

resource "intersight_deviceconnector_policy" "local_config_allowed" {
  name = "local_allowed"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  lockout_enabled = false
}
