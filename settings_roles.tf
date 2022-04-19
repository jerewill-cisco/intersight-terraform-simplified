data "intersight_iam_role" "all" {
  # Here we are not selecting any specific permission, but instead returning all of them
  # so that we don't have to create a new data resource for every permission we want to assign
  #
  # we can then use a splat technique to find the index of the permission that we want and use it
  # for example, the MOID of the Read-Only permission...
  # moid = data.intersight_iam_role.all.results[index(data.intersight_iam_role.all.results.*.name, "Read-Only")].moid
}

resource "intersight_iam_permission" "tier1tech" {
  name = "tier1tech"
}

resource "intersight_iam_resource_roles" "tier1tech--org-example--devicetech" {
  permission {
    moid = intersight_iam_permission.tier1tech.moid
  }
  resource {
    moid        = intersight_organization_organization.example.moid
    object_type = intersight_organization_organization.example.object_type
  }
  roles {
    moid = data.intersight_iam_role.all.results[index(data.intersight_iam_role.all.results.*.name, "Device Technician")].moid
  }
}

resource "intersight_iam_resource_roles" "tier1tech--org-default--readonly" {
  permission {
    moid = intersight_iam_permission.tier1tech.moid
  }
  resource {
    moid        = data.intersight_organization_organization.default.results[0].moid
    object_type = data.intersight_organization_organization.default.results[0].object_type
  }
  roles {
    moid = data.intersight_iam_role.all.results[index(data.intersight_iam_role.all.results.*.name, "Read-Only")].moid
  }
}

resource "intersight_iam_permission" "tier1admin" {
  name = "tier1admin"
}

resource "intersight_iam_resource_roles" "tier1admin--org-example--devicetech" {
  permission {
    moid = intersight_iam_permission.tier1admin.moid
  }
  resource {
    moid        = intersight_organization_organization.example.moid
    object_type = intersight_organization_organization.example.object_type
  }
  roles {
    moid = data.intersight_iam_role.all.results[index(data.intersight_iam_role.all.results.*.name, "Server Administrator")].moid
  }
  roles {
    moid = data.intersight_iam_role.all.results[index(data.intersight_iam_role.all.results.*.name, "HyperFlex Cluster Administrator")].moid
  }
}

resource "intersight_iam_resource_roles" "tier1admin--org-default--readonly" {
  permission {
    moid = intersight_iam_permission.tier1admin.moid
  }
  resource {
    moid        = data.intersight_organization_organization.default.results[0].moid
    object_type = data.intersight_organization_organization.default.results[0].object_type
  }
  roles {
    moid = data.intersight_iam_role.all.results[index(data.intersight_iam_role.all.results.*.name, "Read-Only")].moid
  }
}
