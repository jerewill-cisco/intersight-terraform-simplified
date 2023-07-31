
## UUIDs should always be unique.  Here, we use the random ID resources from
## the random provider to get uniqueness.  We use a bit of format and substring
## to insert the dashes and version values to get an 8-4-4-4-12 representation.

## https://registry.terraform.io/providers/hashicorp/random/latest

resource "random_id" "uuid_prefix_seed" {
  byte_length = 8
}

# We are using the count meta argument to generate multiple suffix seeds so that
# we get a bunch of UUID suffix blocks from the same resource.
resource "random_id" "uuid_suffix_seed" {
  byte_length = 8
  count       = 10 # This controls how many 1000-UUID-suffix-blocks we end up with.  So a 5 here creates a pool with 5000 UUIDs.
}

## This isn't a perfect UUID Generator, but they are really reasonable looking Version 4, Variant 1 compliant UUIDs.
resource "intersight_uuidpool_pool" "default" {
  name = "default"
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

  assignment_order = "default"
  prefix           = upper(format("%s-%s-4%s", substr(random_id.uuid_prefix_seed.hex, 0, 8), substr(random_id.uuid_prefix_seed.hex, 8, 4), substr(random_id.uuid_prefix_seed.hex, 12, 3)))

  dynamic "uuid_suffix_blocks" {
    for_each = random_id.uuid_suffix_seed
    content {
      from = upper(format("8%s-%s", substr(uuid_suffix_blocks.value.hex, 0, 3), substr(uuid_suffix_blocks.value.hex, 3, 12)))
      size = 1000
    }
  }

  lifecycle {
    ignore_changes = [uuid_suffix_blocks]
  }

}
