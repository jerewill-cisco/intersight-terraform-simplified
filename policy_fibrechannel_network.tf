resource "intersight_vnic_fc_network_policy" "vsan1" {
  name = "vsan1"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  vsan_settings {
    id = 1
  }

}
