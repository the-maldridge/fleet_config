resource "routeros_ip_pool" "pool" {
  name    = "lan"
  ranges  = ["${cidrhost(var.subnet, 2)}-${cidrhost(var.subnet, 240)}"]
  comment = "LAN Default IP Pool"
}

resource "routeros_ip_dhcp_server" "server" {
  interface          = routeros_interface_vlan.vlan["lan0"].name
  name               = "LAN"
  address_pool       = routeros_ip_pool.pool.name
  comment            = "LAN Default DHCP Server"
  conflict_detection = true
}

resource "routeros_ip_dhcp_server_network" "network" {
  address    = var.subnet
  comment    = "Options for LAN"
  gateway    = cidrhost(var.subnet, 1)
  domain     = var.domain_name
  dns_server = [cidrhost(var.subnet, 1)]
}

resource "routeros_ip_dhcp_server_lease" "lease" {
  for_each = var.static_hosts

  address     = each.value.addr
  mac_address = each.value.mac
  comment     = each.key
  server      = routeros_ip_dhcp_server.server.name
}

resource "routeros_ip_dns_record" "static_hosts" {
  for_each = var.static_hosts

  name    = format("%s.%s", each.key, var.domain_name)
  address = each.value.addr
  type    = "A"
}

resource "routeros_ip_dns_record" "static_cnames" {
  for_each = merge([for host, data in var.static_hosts : { for cname in data.cname : cname => host } if length(data.cname) > 0]...)

  name  = format("%s.%s", each.key, var.domain_name)
  type  = "CNAME"
  cname = format("%s.%s", each.value, var.domain_name)
}
