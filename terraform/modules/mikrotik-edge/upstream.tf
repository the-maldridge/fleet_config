resource "routeros_ip_dhcp_client" "upstream" {
  interface         = routeros_interface_vlan.vlan["wan0"].name
  add_default_route = "yes"
  use_peer_ntp      = false
  use_peer_dns      = var.use_site_dns
  comment           = "External Upstream"
}
