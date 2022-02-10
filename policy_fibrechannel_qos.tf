resource "intersight_vnic_fc_qos_policy" "default" {
  name = "default"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  rate_limit          = 0
  cos                 = 3
  burst               = 10240
  max_data_field_size = 2112
}
