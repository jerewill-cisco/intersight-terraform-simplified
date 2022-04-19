data "intersight_asset_device_registration" "all" {
}

# This TF resource creates a Resource Group for each PlatformType that is claimed in Intersight
resource "intersight_resource_group" "resource_group_by_platform_type" {
  for_each = toset(data.intersight_asset_device_registration.all.results.*.platform_type)

  name = each.key

  qualifier = "Allow-Selectors"

  selectors {
    selector = format("/api/v1/asset/DeviceRegistrations?$filter=PlatformType eq '%s'", each.key)
  }

}
