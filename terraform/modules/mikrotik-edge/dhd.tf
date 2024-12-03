resource "routeros_ip_firewall_addr_list" "local" {
  list    = "local"
  address = var.subnets["mgmt"]
  comment = "Local Networks"
}

resource "routeros_routing_bgp_connection" "stargate" {
  as = 64582

  name           = "stargate"
  connect        = true
  listen         = true
  router_id      = var.router_id
  hold_time      = "30s"
  keepalive_time = "10s"
  nexthop_choice = "force-self"

  local {
    role    = "ebgp"
    address = "169.254.250.2"
  }

  remote {
    address = "169.254.250.1"
    as      = 64580
  }

  output {
    default_originate = "if-installed"
    redistribute      = "connected,bgp"
    network           = "local"
  }
}
