module "router" {
  source = "../modules/mikrotik-edge"

  hostname = "edge0"
  subnets = {
    lan  = "10.0.0.0/20"
    mgmt = "172.16.34.0/24"
  }

  peer_address = "169.254.255.8/24"
  router_id    = "169.255.255.8"
  domain_name  = "sneaky.nonroutable.network"

  ports = {
    mgmt = ["ether1"]
    wan  = ["sfp-sfpplus1"]
    peer = ["sfp-sfpplus2"]
  }

  trunks = ["sfp-sfpplus10"]

  bonds = {
    bond0 = formatlist("sfp-sfpplus%d", [11, 12])
  }

  additional_nat_subnets = [
    "100.64.0.0/24",
    "169.254.255.0/24",
  ]

  static_hosts = var.static_hosts
}
