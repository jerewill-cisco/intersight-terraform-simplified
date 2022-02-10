resource "intersight_server_profile_template" "example-fi-attached" {
  name = "example-fi-attached"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  target_platform = "FIAttached"
  uuid_address_type = "POOL"

  uuid_pool {
    moid = intersight_uuidpool_pool.default.moid
  }

  ### 
  ### Compute Configuration
  ###
  policy_bucket { # BIOS
    moid        = intersight_bios_policy.performance.moid
    object_type = intersight_bios_policy.performance.object_type
  }

  policy_bucket { # Boot Order
    moid        = intersight_boot_precision_policy.UEFI_m2_RAID.moid
    object_type = intersight_boot_precision_policy.UEFI_m2_RAID.object_type
  }

  policy_bucket { # Power
    moid        = intersight_power_policy.grid_last_state.moid
    object_type = intersight_power_policy.grid_last_state.object_type
  }

  policy_bucket { # Virtual Media
    moid        = intersight_vmedia_policy.vmedia_http_iso.moid
    object_type = intersight_vmedia_policy.vmedia_http_iso.object_type
  }

  ###
  ### Management Configuration
  ###
  #   policy_bucket { # Certificate Management
  #     moid        = ""
  #     object_type = ""
  #   }

  policy_bucket { # IMC Access
    moid        = intersight_access_policy.inband_imc.moid
    object_type = intersight_access_policy.inband_imc.object_type
  }

  policy_bucket { # IPMI Over LAN
    moid        = intersight_ipmioverlan_policy.disabled.moid
    object_type = intersight_ipmioverlan_policy.disabled.object_type
  }

  policy_bucket { # Local User
    moid        = intersight_iam_end_point_user_policy.default.moid
    object_type = intersight_iam_end_point_user_policy.default.object_type
  }

  policy_bucket { #Serial Over LAN
    moid        = intersight_sol_policy.disabled.moid
    object_type = intersight_sol_policy.disabled.object_type
  }

  policy_bucket { # SNMP
    moid        = intersight_snmp_policy.disabled.moid
    object_type = intersight_snmp_policy.disabled.object_type
  }

  policy_bucket { # Syslog
    moid        = intersight_syslog_policy.local_only.moid
    object_type = intersight_syslog_policy.local_only.object_type
  }

  policy_bucket { # Virtual KVM
    moid        = intersight_kvm_policy.default.moid
    object_type = intersight_kvm_policy.default.object_type
  }

  ###
  ### Storage Configuration
  ###
  #   policy_bucket { # SD Card
  #     moid        = ""
  #     object_type = ""
  #   }

  policy_bucket { # Storage
    moid        = intersight_storage_storage_policy.m2_RAID1.moid
    object_type = intersight_storage_storage_policy.m2_RAID1.object_type
  }

  ###
  ### Network Configuration
  ###
  policy_bucket { # LAN Connectivity
    moid        = intersight_vnic_lan_connectivity_policy.esxi.moid
    object_type = intersight_vnic_lan_connectivity_policy.esxi.object_type
  }

  policy_bucket { #SAN Connectivity
    moid        = intersight_vnic_san_connectivity_policy.esxi.moid
    object_type = intersight_vnic_san_connectivity_policy.esxi.object_type
  }

}
