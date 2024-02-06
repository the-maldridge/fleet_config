module "router" {
  source = "../modules/mikrotik-edge"

  hostname = "edge0"
  subnet   = "172.16.31.0/24"

  peer_address = "169.254.255.5/24"
  domain_name  = "sneaky.nonroutable.network"

  ports = {
    lan  = formatlist("ether%d", [6, 7, 8, 9, 10])
    wan  = formatlist("ether%d", [1])
    peer = formatlist("ether%d", [2, 3, 4, 5])
  }

  static_hosts = var.static_hosts
}
