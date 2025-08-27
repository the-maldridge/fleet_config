resource "routeros_ip_dhcp_client" "upstream" {
  interface         = routeros_interface_vlan.vlan["wan0"].name
  add_default_route = "yes"
  use_peer_ntp      = false
  use_peer_dns      = var.use_site_dns
  comment           = "Default Upstream"
  check_gateway     = "arp"
}

resource "routeros_ip_dhcp_client" "supplemental" {
  for_each = var.additional_upstreams

  interface         = routeros_interface_vlan.upstream[each.key].name
  add_default_route = "yes"
  use_peer_ntp      = false
  use_peer_dns      = var.use_site_dns
  comment           = each.value.description
  check_gateway     = "arp"
}
