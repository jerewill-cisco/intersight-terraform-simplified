resource "intersight_chassis_profile" "example" {
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

  target_platform = "FIAttached"
  type            = "instance"

  policy_bucket { # IMC Access
    moid        = intersight_access_policy.inband_imc.moid
    object_type = intersight_access_policy.inband_imc.object_type
  }

  policy_bucket { # Power
    moid        = intersight_power_policy.grid_last_state.moid
    object_type = intersight_power_policy.grid_last_state.object_type
  }

  policy_bucket { # SNMP
    moid        = intersight_snmp_policy.disabled.moid
    object_type = intersight_snmp_policy.disabled.object_type
  }

  policy_bucket { # Thermal
    moid        = intersight_thermal_policy.thermal["Balanced"].moid
    object_type = intersight_thermal_policy.thermal["Balanced"].object_type
  }

}
