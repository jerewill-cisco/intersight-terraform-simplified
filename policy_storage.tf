resource "intersight_storage_storage_policy" "m2_RAID1" {
  name = "m2_RAID1"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  use_jbod_for_vd_creation = false
  unused_disks_state       = "UnconfiguredGood"

  m2_virtual_drive {
    enable          = true
    controller_slot = "MSTOR-RAID-1"
  }

}
