module "router" {
  source = "../modules/mikrotik-edge"

  hostname = "edge0"
  subnet   = "172.16.31.0/24"

  peer_address = "169.254.255.5/24"
  router_id    = "169.255.255.5"
  domain_name  = "sneaky.nonroutable.network"

  ports = {
    lan  = formatlist("ether%d", [6, 7, 8, 9, 10])
    wan  = formatlist("ether%d", [1])
    peer = flatten(["sfp1", formatlist("ether%d", [2, 3, 4, 5])])
  }

  additional_nat_subnets = [
    "172.24.0.0/23",
    "172.16.29.0/24",
    "172.16.30.0/24",
    "192.168.33.0/24",
    "169.254.250.0/30",
  ]

  static_hosts = var.static_hosts
}
