resource "routeros_ip_pool" "pool" {
  for_each = var.subnets

  name    = each.key
  ranges  = ["${cidrhost(each.value, 2)}-${cidrhost(each.value, pow(2, (32 - split("/", each.value)[1])) - 10)}"]
  comment = "LAN Default IP Pool"
}

resource "routeros_ip_dhcp_server_option" "cme_addr" {
  code    = 150
  name    = "cisco-telephony"
  value   = "'${var.cme_addr}'"
  comment = "cisco-telephony"
}

resource "routeros_ip_dhcp_server_option_set" "telephony" {
  name = "telephony"
  options = join(",", [
    routeros_ip_dhcp_server_option.cme_addr.name,
  ])
}

resource "routeros_ip_dhcp_server" "server" {
  for_each = var.subnets

  interface          = routeros_interface_vlan.vlan[format("%s0", each.key)].name
  name               = upper(each.key)
  address_pool       = routeros_ip_pool.pool[each.key].name
  comment            = format("%s Default DHCP Server", upper(each.key))
  conflict_detection = true
  lease_time         = var.dhcp_lease_time
}

resource "routeros_ip_dhcp_server_network" "network" {
  for_each = var.subnets

  address    = each.value
  comment    = format("Options for %s", upper(each.key))
  gateway    = cidrhost(each.value, 1)
  domain     = var.domain_name
  dns_server = [cidrhost(each.value, 1)]

  dhcp_option_set = routeros_ip_dhcp_server_option_set.telephony.name
}

resource "routeros_ip_dhcp_server_lease" "lease" {
  for_each = var.static_hosts

  address     = each.value.addr
  mac_address = each.value.mac
  comment     = each.key
  server      = routeros_ip_dhcp_server.server[each.value.server].name
}

resource "routeros_ip_dns_record" "static_hosts" {
  for_each = var.static_hosts

  name    = format("%s.%s", each.key, var.domain_name)
  address = each.value.addr
  type    = "A"
}

resource "routeros_ip_dns_record" "static_cnames" {
  for_each = merge([for host, data in var.static_hosts : { for cname in data.cname : cname => host } if length(data.cname) > 0]...)

  name  = endswith(each.key, ".") ? trimsuffix(each.key, ".") : format("%s.%s", each.key, var.domain_name)
  type  = "CNAME"
  cname = format("%s.%s", each.value, var.domain_name)
}
