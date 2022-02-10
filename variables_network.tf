variable "network_map_infra" {
  type = map(object({
    vlan = number
    qos  = string
  }))
  default = {
    inband_vmware = {
      vlan = 100
      qos  = "silver"
    }
    inband_ucs = {
      vlan = 200
      qos  = "silver"
    }
    outofband_ucs = {
      vlan = 300
      qos  = "silver"
    }
    iscsi_a = {
      vlan = 401
      qos  = "bronze"
    }
    iscsi_b = {
      vlan = 402
      qos  = "bronze"
    }
    vmotion = {
      vlan = 500
      qos  = "bronze"
    }
  }
}

variable "network_map_vmnetwork" {
  type = map(object({
    vlan = number
    qos  = string
  }))
  default = {
    isolate = {
      vlan = 2
      qos  = "be"
    }
    webservers = {
      vlan = 1001
      qos  = "gold"
    }
    databaseservers = {
      vlan = 1002
      qos  = "gold"
    }
    backendservices = {
      vlan = 1003
      qos  = "gold"
    }
    desktops = {
      vlan = 1004
      qos  = "gold"
    }
    vdiservices = {
      vlan = 1005
      qos  = "gold"
    }
  }
}
