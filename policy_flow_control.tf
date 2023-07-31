resource "intersight_fabric_flow_control_policy" "pfc" {
  name = "pfc"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  priority_flow_control_mode = "on"
  receive_direction          = "Disabled"
  send_direction             = "Disabled"

}

resource "intersight_fabric_flow_control_policy" "llfc" {
  name = "llfc"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  priority_flow_control_mode = "off"
  receive_direction          = "Enabled"
  send_direction             = "Enabled"

}
