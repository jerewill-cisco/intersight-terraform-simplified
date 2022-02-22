resource "intersight_kvm_policy" "default" {
  name = "default"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  enabled                   = true
  maximum_sessions          = 4
  remote_port               = 2068
  enable_video_encryption   = true
  enable_local_server_video = true

  ## This really should be a native attribute like this...
  # tunneled_kvm_enabled      = true 
  ## But it's not yet... so use additional_properties instead.
  additional_properties = jsonencode({ TunneledKvmEnabled = true })
}
