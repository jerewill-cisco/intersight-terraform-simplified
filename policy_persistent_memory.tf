# This resource appears to be broken
# https://github.com/CiscoDevNet/terraform-provider-intersight/issues/180
resource "intersight_memory_persistent_memory_policy" "configured_from_os" {
  name = "configured_from_os"
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

  management_mode = "configured-from-operating-system"
}
