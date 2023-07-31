resource "intersight_kvm_policy" "default" {
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

  enabled                   = true
  maximum_sessions          = 4
  remote_port               = 2068
  enable_video_encryption   = true
  enable_local_server_video = true
  tunneled_kvm_enabled      = true

}
