resource "intersight_fabric_link_aggregation_policy" "default" {
  name = "default"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  lacp_rate          = "normal"
  suspend_individual = true

}
