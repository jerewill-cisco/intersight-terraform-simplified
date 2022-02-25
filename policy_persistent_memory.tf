resource "intersight_memory_persistent_memory_policy" "configured_from_os" {
  name = "configured_from_os"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  management_mode = "configured-from-operating-system"
}
