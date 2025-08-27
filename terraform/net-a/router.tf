module "router" {
  source = "../modules/mikrotik-edge"

  hostname = "edge0"
  subnets = {
    lan   = "10.10.0.0/20"
    trust = "10.11.0.0/20"
    mgmt  = "172.16.34.0/24"
  }
  dhcp_lease_time = "3h"

  additional_upstreams = {
    skynet  = { id = 21, description = "SkyNet" }
    tmobile = { id = 22, description = "T-Mobile" }
    att     = { id = 23, description = "AT&T" }
    cbrs    = { id = 24, description = "Sketchy-CBRS" }
  }

  peer_address = "169.254.255.8/24"
  router_id    = "169.255.255.8"
  domain_name  = "sneaky.nonroutable.network"

  cme_addr = "172.16.34.5"

  ports = {
    mgmt = ["ether1", "sfp-sfpplus9"]
    wan  = ["sfp-sfpplus1"]
    peer = ["sfp-sfpplus2"]
  }

  trunks = formatlist("sfp-sfpplus%d", [3, 4, 5, 6])

  bonds = {
    bond0 = formatlist("sfp-sfpplus%d", [11, 12])
  }

  additional_nat_subnets = [
    "169.254.255.0/24",
    "172.16.29.0/24",
    "172.16.31.0/24",
  ]

  static_hosts = var.static_hosts
}
