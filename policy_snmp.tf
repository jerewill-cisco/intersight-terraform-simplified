resource "intersight_snmp_policy" "disabled" {
  name = "disabled"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  enabled    = false
  v2_enabled = false
  v3_enabled = false

}

resource "intersight_snmp_policy" "disabled_duplicate" {
  # due to another issue, we have to use separate policy for domain profiles also.
  # https://github.com/CiscoDevNet/terraform-provider-intersight/issues/170
  name = "disabled_duplicate"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  enabled    = false
  v2_enabled = false
  v3_enabled = false

  # This is a temporary workaround to the bug in intersight_fabric_switch_profile policy_bucket
  # we are attaching the profile to the policy here instead of attaching the policy to the profile in profile_ucs_domain.tf
  dynamic "profiles" {
    for_each = intersight_fabric_switch_profile.example
    content {
      moid        = profiles.value.moid
      object_type = profiles.value.object_type
    }
  }

}

resource "intersight_snmp_policy" "snmpv2c" {
  name = "snmpv2c"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  v2_enabled              = true
  v3_enabled              = false
  enabled                 = true
  snmp_port               = 161
  access_community_string = "readonly999"
  community_access        = "Limited"
  sys_contact             = "itops@email.com"
  sys_location            = "SJC-Building999"
}

resource "intersight_snmp_policy" "snmpv3" {
  name = "snmpv3"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  v2_enabled   = false
  v3_enabled   = true
  enabled      = true
  snmp_port    = 161
  sys_contact  = "itops@email.com"
  sys_location = "SJC-Building999"

  snmp_users {
    name             = "ucs"
    auth_type        = "SHA"
    privacy_type     = "AES"
    security_level   = "AuthPriv"
    auth_password    = var.imc_local_admin_password
    privacy_password = var.imc_local_admin_password
  }

  snmp_traps {
    enabled     = true
    nr_version  = "V3"
    user        = "ucs" # must be defined in an snmp_users block
    type        = "Trap"
    destination = "snmptraps.example.com"
    port        = 162
  }
}
