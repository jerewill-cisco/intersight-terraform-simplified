
resource "intersight_firmware_policy" "August2023" {
  name = "August2023"
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

  model_bundle_combo {
    model_family   = "UCSX-210C-M6"
    bundle_version = "5.1(0.230075)"
  }
  model_bundle_combo {
    model_family   = "UCSC-C220-M5"
    bundle_version = "4.2(3e)"
  }
}
