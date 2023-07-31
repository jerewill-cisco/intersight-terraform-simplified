resource "intersight_iam_ldap_policy" "disabled" {
  name = "disabled"
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
  enabled = false
}

resource "intersight_iam_ldap_policy" "example" {
  name = "example"
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

  enabled                = true
  enable_dns             = true
  user_search_precedence = "LocalUserDb"

  base_properties {
    attribute                  = "CiscoAvPair"
    base_dn                    = "DC=example,DC=com"
    bind_dn                    = "CN=administrator,CN=Users,DC=example,DC=com"
    bind_method                = "Anonymous"
    domain                     = "example.com"
    enable_encryption          = true
    enable_group_authorization = true
    filter                     = "sAMAccountName"
    group_attribute            = "memberOf"
    nested_group_search_depth  = 128
    timeout                    = 180
  }

  dns_parameters {
    nr_source = "Extracted"
  }

}

## This data souce is defined in policy_local_user.tf instead of in this file.
## One place is not more right than the other, but it has to be somewhere.
##
## This data source retrieves a system built-in role that we want to assign to the admin user.
# data "intersight_iam_end_point_role" "imc_admin" {
#   name      = "admin"
#   role_type = "endpoint-admin"
#   type      = "IMC"
# }

resource "intersight_iam_ldap_group" "ucs_admin" {
  name = "ucs_admin"
  dynamic "tags" {
    for_each = local.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }

  domain = "example.com"

  end_point_role {
    moid = data.intersight_iam_end_point_role.imc_admin.results[0].moid
  }

  ldap_policy {
    moid = intersight_iam_ldap_policy.example.moid
  }

}
