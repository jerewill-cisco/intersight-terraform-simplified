resource "intersight_vnic_fc_qos_policy" "default" {
  name = "default"
  dynamic "tags" {
    for_each = local.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }
  organization {
    moid = local.organization
  }

  rate_limit          = 0
  cos                 = 3
  burst               = 10240
  max_data_field_size = 2112
}
