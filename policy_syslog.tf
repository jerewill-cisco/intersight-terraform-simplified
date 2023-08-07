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

  local_clients {
    min_severity = "warning"
  }

}

resource "intersight_syslog_policy" "local_only_duplicate" {
  # due to another issue, we have to use separate policy for domain profiles also.
  # https://github.com/CiscoDevNet/terraform-provider-intersight/issues/170
  name = "local_only_duplicate"
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

  local_clients {
    min_severity = "warning"
  }
}
