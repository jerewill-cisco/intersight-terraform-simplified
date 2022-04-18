data "intersight_iam_idp" "idp" {
  domain_name = "example.com"  # this is the domain name associated with the IdP
}

## Assign Account Admin role based on a group assertion from the IdP

data "intersight_iam_permission" "accountadmin" {
  name = "Account Administrator" # this is one of the built-in roles
}

resource "intersight_iam_user_group" "idp-accountadmin" {
  name = "idp-account-administrator"

  idp {
    moid = data.intersight_iam_idp.idp.results[0].moid
  }

  permissions {
    moid        = data.intersight_iam_permission.accountadmin.results[0].moid
    object_type = data.intersight_iam_permission.accountadmin.results[0].object_type
  }

}

resource "intersight_iam_qualifier" "intersight_admin" {
    value = [ "intersight_admin" ] # this is the name of the group in the memberOf field of the assertion

    usergroup {
        moid = intersight_iam_user_group.idp-accountadmin.moid
    }
}

## Assign a custom role based on a group assertion from the IdP

data "intersight_iam_permission" "tier1admin" {
  name = "tier1admin" # this is a custom role
}

resource "intersight_iam_user_group" "idp-tier1admin" {
  name = "idp-tier1admin"

  idp {
    moid = data.intersight_iam_idp.idp.results[0].moid
  }

  permissions {
    moid        = data.intersight_iam_permission.tier1admin.results[0].moid
    object_type = data.intersight_iam_permission.tier1admin.results[0].object_type
  }

}

resource "intersight_iam_qualifier" "intersight_tier1admin" {
    value = [ "intersight_tier1admin" ] # this is the name of the group in the memberOf field of the assertion

    usergroup {
        moid = intersight_iam_user_group.idp-tier1admin.moid
    }
}
