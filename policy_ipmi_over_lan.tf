resource "intersight_ipmioverlan_policy" "disabled" {
  name = "disabled"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  enabled = false
}
