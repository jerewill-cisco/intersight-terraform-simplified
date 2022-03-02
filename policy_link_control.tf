resource "intersight_fabric_link_control_policy" "default" {
  name = "default"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  udld_settings {
    admin_state = "Enabled"
    mode        = "normal"
  }

}
