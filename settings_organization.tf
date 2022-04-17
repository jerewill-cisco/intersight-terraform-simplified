# Here we lookup the default organization
data "intersight_organization_organization" "default" {
  name = "default"
}

resource "intersight_organization_organization" "example" {
  name = "example"
}
