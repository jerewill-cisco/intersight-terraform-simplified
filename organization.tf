# At this point, we've chosed not to create organizations, but we do
# need to specify the organization in case more than one exists.

# data "intersight_organization_organization" "terraform" {
#   name = "terraform"
# }

# Here we lookup the default organization
data "intersight_organization_organization" "default" {
  name = "default"
}
