resource "intersight_fabric_multicast_policy" "default" {
  name = "default"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  snooping_state = "Enabled"
  querier_state  = "Disabled"
}
