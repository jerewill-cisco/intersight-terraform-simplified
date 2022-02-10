##
## Severity Reference for SYSLOG
##    emergency
##    alert
##    critical
##    error
##    warning
##    notice
##    informational
##    debug
##

resource "intersight_syslog_policy" "remote" {
  name = "remote"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  local_clients {
    min_severity = "warning"
  }

  remote_clients {
    enabled      = true
    hostname     = "syslog.local"
    port         = 514
    protocol     = "udp"
    min_severity = "warning"
  }

  remote_clients {
    enabled      = true
    hostname     = "splunk.local"
    port         = 6514
    protocol     = "tcp"
    min_severity = "notice"
  }

}

resource "intersight_syslog_policy" "local_only" {
  name = "local_only"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  local_clients {
    min_severity = "warning"
  }

}

resource "intersight_syslog_policy" "local_only_duplicate" {
  # due to another issue, we have to use separate policy for domain profiles also.
  # https://github.com/CiscoDevNet/terraform-provider-intersight/issues/170
  name = "local_only_duplicate"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  local_clients {
    min_severity = "warning"
  }

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
