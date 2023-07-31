resource "intersight_power_policy" "grid_last_state" {
  name = "grid_last_state"
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

  power_profiling     = "Enabled"
  power_restore_state = "LastState"
  redundancy_mode     = "Grid"
}

resource "intersight_power_policy" "grid_power_on" {
  name = "grid_power_on"
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

  power_profiling     = "Enabled"
  power_restore_state = "AlwaysOn"
  redundancy_mode     = "Grid"
}

resource "intersight_power_policy" "grid_power_off" {
  name = "grid_power_off"
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

  power_profiling     = "Enabled"
  power_restore_state = "AlwaysOff"
  redundancy_mode     = "Grid"
}
