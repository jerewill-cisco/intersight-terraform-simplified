resource "intersight_fabric_switch_cluster_profile" "example" {
  name = "example"
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

  type = "instance"
}

resource "intersight_fabric_switch_profile" "example" {
  for_each = toset(["A", "B"])

  name = "example-${each.key}"
  dynamic "tags" {
    for_each = local.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }

  type = "instance"
  # We are currently unable to use the policy bucket syntax on this resource.
  # Each of the policies that would be attached here are instead attaching themselves
  # to this profile.  This isn't really desirable, but it's a workaround for now.
  # https://github.com/CiscoDevNet/terraform-provider-intersight/issues/166
  #
  #   policy_bucket { # VLAN Configuration
  #     moid        = intersight_fabric_eth_network_policy.default.moid
  #     object_type = intersight_fabric_eth_network_policy.default.object_type
  #   }
  #   policy_bucket { # VSAN Configuration
  #     moid        = intersight_fabric_fc_network_policy.default.moid
  #     object_type = intersight_fabric_fc_network_policy.default.object_type
  #   }
  #   policy_bucket { # Port Policy
  #     moid        = intersight_fabric_port_policy.default-6454.moid
  #     object_type = intersight_fabric_port_policy.default-6454.object_type
  #   }
  #   policy_bucket { # NTP Policy
  #     moid        = intersight_ntp_policy.us_ntp["us_eastern"].moid
  #     object_type = intersight_ntp_policy.us_ntp["us_eastern"].object_type
  #   }
  #   policy_bucket { # SNMP
  #     moid        = intersight_snmp_policy.disabled.moid
  #     object_type = intersight_snmp_policy.disabled.object_type
  #   }
  #   policy_bucket { # Switch Control Policy
  #     moid = intersight_fabric_switch_control_policy.default.moid
  #     object_type = intersight_fabric_switch_control_policy.default.object_type
  #   }
  #   policy_bucket { # Syslog
  #     moid        = intersight_syslog_policy.local_only.moid
  #     object_type = intersight_syslog_policy.local_only.object_type
  #   }
  #   policy_bucket { # System QoS Policy
  #     moid        = intersight_fabric_system_qos_policy.default.moid
  #     object_type = intersight_fabric_system_qos_policy.default.object_type
  #   }
  #   policy_bucket { # Network Connectivity
  #     moid = intersight_networkconfig_policy.default.moid
  #     object_type = intersight_networkconfig_policy.default.object_type
  #   }

  switch_cluster_profile {
    moid = intersight_fabric_switch_cluster_profile.example.moid
  }
}
