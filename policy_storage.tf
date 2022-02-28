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


resource "intersight_storage_storage_policy" "local_raid" {
  name = "local_raid"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  use_jbod_for_vd_creation = true
  unused_disks_state       = "UnconfiguredGood"

  m2_virtual_drive {
    enable          = false
    controller_slot = "MSTOR-RAID-1"
  }

}

resource "intersight_storage_drive_group" "raid1_dg" {
  name = "raid1_dg"
  tags = [local.terraform]

  # type       = 0 # manual drive slot selection
  raid_level = "Raid1"

  manual_drive_group {
    span_groups {
      slots = "1,2"
    }
  }

  virtual_drives {
    name                = "raid1_vd"
    boot_drive          = false
    size                = 1
    expand_to_available = true
    virtual_drive_policy {
      strip_size    = 64
      write_policy  = "WriteThrough"
      read_policy   = "NoReadAhead"
      access_policy = "ReadWrite"
    }
  }

  storage_policy {
    moid = intersight_storage_storage_policy.local_raid.moid
  }

}

resource "intersight_storage_drive_group" "raid5_dg" {
  name = "raid5_dg"
  tags = [local.terraform]

  # type       = 0 # manual drive slot selection
  raid_level = "Raid5"

  manual_drive_group {
    span_groups {
      slots = "4,5,6,7,8,9,10"
    }
  }

  virtual_drives {
    name                = "raid5_vd"
    boot_drive          = false
    size                = 1
    expand_to_available = true
    virtual_drive_policy {
      strip_size    = 64
      write_policy  = "WriteThrough"
      read_policy   = "NoReadAhead"
      access_policy = "ReadWrite"
    }
  }

  storage_policy {
    moid = intersight_storage_storage_policy.local_raid.moid
  }

}
