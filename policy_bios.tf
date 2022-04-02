##
## BIOS Policy Guidance
##
## In general, "platform-default" is a reasonable choice for any setting.
## For more guidance, please see the performance tuning whitepapers.
## M5: https://www.cisco.com/c/en/us/products/collateral/servers-unified-computing/ucs-b-series-blade-servers/white-paper-c11-744678.html
## M6: https://www.cisco.com/c/en/us/products/collateral/servers-unified-computing/ucs-b-series-blade-servers/performance-tuning-guide-ucs-m6-servers.html
##
## TERRAFORM resource for BIOS policy: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/bios_policy
##


resource "intersight_bios_policy" "platform-defaults" {
  name = "platform-defaults"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }
}

### General Purpose Workloads

resource "intersight_bios_policy" "cpu-intensive" {
  name = "cpu-intensive"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  ## Customizations
  adjacent_cache_line_prefetch          = "disabled"
  streamer_prefetch                     = "disabled"
  llc_prefetch                          = "disabled"
  cpu_perf_enhancement                  = "Auto"
  processor_c1e                         = "enabled"
  processor_c6report                    = "enabled"
  work_load_config                      = "Balanced"
  ### UPI prefetch seems to be missing from terraform
  xpt_prefetch                          = "enabled"
  upi_link_enablement                   = "1"
  upi_power_management                  = "enabled"
  snc                                   = "enabled"
  ufs_disable                           = "disabled"
  llc_alloc                             = "disabled"
  imc_interleave                        = "1-way Interleave"
  select_memory_ras_configuration       = "maximum-performance"
  dram_refresh_rate                     = "1x"
  patrol_scrub                          = "disabled"
}

resource "intersight_bios_policy" "io-intensive" {
  name = "io-intensive"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  ## Customizations
  cpu_performance                       = "custom"
  hardware_prefetch                     = "disabled"
  adjacent_cache_line_prefetch          = "disabled"
  streamer_prefetch                     = "disabled"
}

resource "intersight_bios_policy" "energy-efficient" {
  name = "energy-efficient"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  ## Customizations
  cpu_performance                       = "custom"
  hardware_prefetch                     = "disabled"
  adjacent_cache_line_prefetch          = "disabled"
  ip_prefetch                           = "disabled"
  streamer_prefetch                     = "disabled"
  processor_c1e                         = "enabled"
  processor_c6report                    = "enabled"
  package_cstate_limit                  = "C6 Non Retention"
  work_load_config                      = "Balanced"
}

resource "intersight_bios_policy" "low-latency" {
  name = "low-latency"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  ## Customizations
  intel_virtualization_technology       = "disabled"
  intel_vt_for_directed_io              = "disabled"
  intel_turbo_boost_tech                = "disabled"
  energy_efficient_turbo                = "disabled"
  work_load_config                      = "Balanced"
  dram_refresh_rate                     = "1x"
  patrol_scrub                          = "disabled"
}


### Enterprise Workloads


resource "intersight_bios_policy" "relational-db" {
  name = "relational-db"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  ## Customizations
  llc_prefetch                          = "disabled"
  cpu_perf_enhancement                  = "Auto"
  processor_c1e                         = "disabled"
  energy_efficient_turbo                = "disabled"
  xpt_prefetch                          = "enabled"
  upi_power_management                  = "enabled"
  snc                                   = "enabled"
  llc_alloc                             = "disabled"
  imc_interleave                        = "1-way Interleave"
  dram_refresh_rate                     = "1x"
  patrol_scrub                          = "disabled"
}

resource "intersight_bios_policy" "virtualization" {
  name = "virtualization"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  ## Customizations
  cpu_perf_enhancement                  = "Auto"
}

resource "intersight_bios_policy" "analytical-db" {
  name = "analytical-db"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  ## Customizations
  intel_virtualization_technology       = "disabled"
  intel_vt_for_directed_io              = "disabled"
  cpu_perf_enhancement                  = "Auto"
  processor_c1e                         = "disabled"
  work_load_config                      = "Balanced"
  dram_refresh_rate                     = "1x"
  patrol_scrub                          = "disabled"
}



resource "intersight_bios_policy" "data-analytics" {
  name = "data-analytics"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  ## Customizations
  intel_vt_for_directed_io              = "disabled"
  cpu_perf_enhancement                  = "Auto"
  work_load_config                      = "Balanced"

}

resource "intersight_bios_policy" "high-performance-computing" {
  name = "high-performance-computing"
  tags = [local.terraform]
  organization {
    moid = local.organization
  }

  ## Customizations
  intel_virtualization_technology       = "disabled"
  llc_prefetch                          = "disabled"
  intel_vt_for_directed_io              = "disabled"
  cpu_perf_enhancement                  = "Auto"
  processor_c1e                         = "disabled"
  processor_c6report                    = "disabled"
  energy_efficient_turbo                = "disabled"
  work_load_config                      = "Balanced"
  xpt_prefetch                          = "enabled"
  upi_power_management                  = "enabled"
  snc                                   = "enabled"
  llc_alloc                             = "disabled"
  imc_interleave                        = "1-way Interleave"
  dram_refresh_rate                     = "1x"
  patrol_scrub                          = "disabled"
}