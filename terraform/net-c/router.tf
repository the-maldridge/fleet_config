module "router" {
  source = "../modules/mikrotik-edge"

  hostname = "edge0"
  subnets = {
    lan   = "100.64.16.0/20"
    trust = "100.64.32.0/20"
    media = "192.0.2.0/24"
    mgmt  = "172.16.35.0/24"
  }

  peer_address = "169.254.255.9/24"
  router_id    = "169.254.255.9"
  domain_name  = "sneaky.nonroutable.network"

  use_site_dns = true
  cme_addr     = "172.16.32.1"

  ports = {
    wan  = formatlist("ether%d", [1])
    lan  = formatlist("ether%d", [2, 3, 4, 5])
    peer = formatlist("ether%d", [6, 7, 8, 9, 10])
    mgmt = formatlist("ether%d", [13])
  }

  trunks = formatlist("ether%s", [11, 12])

  additional_nat_subnets = [
    "172.24.0.0/23",
    "172.16.29.0/24",
    "172.16.30.0/24",
    "192.168.33.0/24",
    "169.254.250.0/30",
  ]

  static_hosts = var.static_hosts
}
