module "router" {
  source = "../modules/mikrotik-edge"

  hostname = "edge0"
  subnets = {
    lan   = "10.0.0.0/20"
    trust = "10.1.0.0/20"
    mgmt  = "172.16.31.0/24"
  }

  peer_address = "169.254.255.5/24"
  router_id    = "169.255.255.5"
  domain_name  = "sneaky.nonroutable.network"

  use_site_dns = true

  ports = {
    lan  = formatlist("ether%d", [6, 7])
    wan  = formatlist("ether%d", [1])
    peer = flatten([formatlist("ether%d", [2, 3, 4]), "sfp1"])
    mgmt = formatlist("ether%d", [5])
  }

  trunks = formatlist("ether%s", [8, 9, 10])

  additional_nat_subnets = [
    "172.24.0.0/23",
    "172.16.29.0/24",
    "172.16.30.0/24",
    "192.168.33.0/24",
    "169.254.250.0/30",
  ]

  static_hosts = var.static_hosts
}
