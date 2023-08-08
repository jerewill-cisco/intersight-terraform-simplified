# This firmware policy statically sets the desired versions
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

# This data resource and firmware policy dynamically creates a set of firmware policies
# for each server family with the version set to the recommended version
data "intersight_firmware_distributable" "recommended" {
  recommended_build = "Y"
  import_state      = "Imported"
  image_type        = "Intersight Managed Mode Server"
}

resource "intersight_firmware_policy" "recommended" {
  for_each = { for i in data.intersight_firmware_distributable.recommended.results : "${i.moid}" => i }
  name     = each.value.mdfid
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
    model_family   = trimsuffix(trimsuffix(trimsuffix(each.value.supported_models[0], "X"), "N"), "S")
    bundle_version = each.value.nr_version
  }

}
