##
## Local User Policies
##
## This policy is more complex in the Intersight API than it appears in the GUI.
## As a result, this object looks a bit more complex in TF that you might expect.
##
## The real goal of the first part of this policy is simply to set the password of the
## built-in admin user.  The additional of a secondary user just extends the concepts.

# This is the base policy, which does not include any users
resource "intersight_iam_end_point_user_policy" "default" {
  name = "default"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  password_properties {
    enforce_strong_password  = false
    enable_password_expiry   = false
    force_send_password      = true
    password_expiry_duration = 1
    password_history         = 1
    notification_period      = 0
    grace_period             = 0
  }

}

##  Admin user

# This resource is a user that will be added to the policy.
resource "intersight_iam_end_point_user" "admin" {
  name = "admin"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }
}

# This data source retrieves a system built-in role that we want to assign to the admin user.
data "intersight_iam_end_point_role" "imc_admin" {
  name      = "admin"
  role_type = "endpoint-admin"
  type      = "IMC"
}

# This resource adds the user to the policy using the role we retrieved.
# Notably, the password is set in this resource and NOT in the user resource above.
resource "intersight_iam_end_point_user_role" "admin" {
  tags = [local.terraform]

  enabled  = true
  password = var.imc_local_admin_password

  end_point_user {
    moid = intersight_iam_end_point_user.admin.moid
  }

  end_point_user_policy {
    moid = intersight_iam_end_point_user_policy.default.moid
  }

  end_point_role {
    moid = data.intersight_iam_end_point_role.imc_admin.results[0].moid
  }

}

## Example user

# This resource is a user that will be added to the policy.
resource "intersight_iam_end_point_user" "example" {
  name = "example"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }
}

# This data source retrieves a system built-in role that we want to assign to the user.
data "intersight_iam_end_point_role" "imc_readonly" {
  name      = "readonly"
  role_type = "endpoint-readonly"
  type      = "IMC"
}

# This user gets a random password because we don't want to be terrible
resource "random_password" "example_password" {
  length  = 16
  special = false
}

# This resource adds the user to the policy using the role we retrieved.
# Notably, the password is set in this resource and NOT in the user resource above.
resource "intersight_iam_end_point_user_role" "example" {
  tags = [local.terraform]

  enabled  = true
  password = random_password.example_password.result

  end_point_user {
    moid = intersight_iam_end_point_user.example.moid
  }

  end_point_user_policy {
    moid = intersight_iam_end_point_user_policy.default.moid
  }

  end_point_role {
    moid = data.intersight_iam_end_point_role.imc_readonly.results[0].moid
  }

}
