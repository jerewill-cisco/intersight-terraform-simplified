locals {
  terraform = {
    additional_properties = ""
    key                   = "Automation"
    value                 = "Terraform"
  }
  # Here we choose the organization where our TF configuration should live
  organization = data.intersight_organization_organization.default.results[0].moid
}
