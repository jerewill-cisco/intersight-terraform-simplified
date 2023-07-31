# ###
# ### The resources in this file are fine example, but they don't work in an empty Intersight account. 
# ### As a result, they've been commented out so that it's easier to get started with this repo. 
# ###

# # Here we show a more advanced example of using tags to deploy server profiles

# # This data source searches for physical servers that have a tag, in this case, os:vmware
# # These tags are added to the servers in Intersight outside of Terraform.
# # Be aware that this data source will fail to plan if it returns 0 results!

# # The syntax here is challenging because of the current limits of intersight_search_search_item
# # So it's basically like an injection attack for the OData syntax where we close the first search
# # term which should be `Presence = equipped` and then add additional search terms to include tags
# # and ObjectType so be careful with the quotes on each end if you adapt this syntax to your own use.

# # See also... https://github.com/CiscoDevNet/terraform-provider-intersight/issues/174
# # for a feature request to improve this situation.

# data "intersight_search_search_item" "os_vmware" {
#   additional_properties = jsonencode({ "Presence" = "equipped' and Tags/any(t:t/Key eq 'os' and t/Value eq 'vmware') and ObjectType eq 'compute.PhysicalSummary" })
# }

# # This resource creates and applies server profiles from the data source above
# # The for_each uses a `for` expression to convert the results of the data source into a map
# resource "intersight_server_profile" "example-esxi-from-tags" {
#   for_each = { for i in data.intersight_search_search_item.os_vmware.results : "${i.moid}" => i }

#   # We use the moid (the key of the map) to name the profile
#   name = format("esxi-%s", each.key)
#   tags = [local.terraform]
#   organization {
#     moid = local.organization
#   }

#   target_platform   = "FIAttached"
#   uuid_address_type = "POOL"
#   action = "Deploy"
#   server_assignment_mode = "Static"

#   # We have to extract the ObjectType from the result because it could be a blade server or a rack server
#   # Since the SourceObjectType isn't presented neatly in the data source, we can decode the
#   # additional_properties attribute and then access it's attributes
#   assigned_server {
#     moid = each.key
#     object_type = jsondecode(each.value.additional_properties).SourceObjectType
#   }

#   uuid_pool {
#     moid = intersight_uuidpool_pool.default.moid
#   }

#     lifecycle {
#     ignore_changes = [action,server_assignment_mode]
#   }

#   ### 
#   ### Compute Configuration
#   ###
#   policy_bucket { # BIOS
#     moid        = intersight_bios_policy.platform-defaults.moid
#     object_type = intersight_bios_policy.platform-defaults.object_type
#   }

#   policy_bucket { # Boot Order
#     moid        = intersight_boot_precision_policy.UEFI_m2_RAID.moid
#     object_type = intersight_boot_precision_policy.UEFI_m2_RAID.object_type
#   }

#   policy_bucket { # Power
#     moid        = intersight_power_policy.grid_last_state.moid
#     object_type = intersight_power_policy.grid_last_state.object_type
#   }

#   #policy_bucket { # Virtual Media
#   #  moid        = intersight_vmedia_policy.vmedia_http_iso.moid
#   #  object_type = intersight_vmedia_policy.vmedia_http_iso.object_type
#   #}

#   ###
#   ### Management Configuration
#   ###
#   #   policy_bucket { # Certificate Management
#   #     moid        = ""
#   #     object_type = ""
#   #   }

#   policy_bucket { # IMC Access
#     moid        = intersight_access_policy.inband_imc.moid
#     object_type = intersight_access_policy.inband_imc.object_type
#   }

#   policy_bucket { # IPMI Over LAN
#     moid        = intersight_ipmioverlan_policy.disabled.moid
#     object_type = intersight_ipmioverlan_policy.disabled.object_type
#   }

#   policy_bucket { # Local User
#     moid        = intersight_iam_end_point_user_policy.default.moid
#     object_type = intersight_iam_end_point_user_policy.default.object_type
#   }

#   policy_bucket { #Serial Over LAN
#     moid        = intersight_sol_policy.disabled.moid
#     object_type = intersight_sol_policy.disabled.object_type
#   }

#   policy_bucket { # SNMP
#     moid        = intersight_snmp_policy.disabled.moid
#     object_type = intersight_snmp_policy.disabled.object_type
#   }

#   policy_bucket { # Syslog
#     moid        = intersight_syslog_policy.local_only.moid
#     object_type = intersight_syslog_policy.local_only.object_type
#   }

#   policy_bucket { # Virtual KVM
#     moid        = intersight_kvm_policy.default.moid
#     object_type = intersight_kvm_policy.default.object_type
#   }

#   ###
#   ### Storage Configuration
#   ###
#   #   policy_bucket { # SD Card
#   #     moid        = ""
#   #     object_type = ""
#   #   }

#   policy_bucket { # Storage
#     moid        = intersight_storage_storage_policy.m2_RAID1.moid
#     object_type = intersight_storage_storage_policy.m2_RAID1.object_type
#   }

#   ###
#   ### Network Configuration
#   ###
#   policy_bucket { # LAN Connectivity
#     moid        = intersight_vnic_lan_connectivity_policy.esxi.moid
#     object_type = intersight_vnic_lan_connectivity_policy.esxi.object_type
#   }

#   policy_bucket { #SAN Connectivity
#     moid        = intersight_vnic_san_connectivity_policy.esxi.moid
#     object_type = intersight_vnic_san_connectivity_policy.esxi.object_type
#   }

# }
