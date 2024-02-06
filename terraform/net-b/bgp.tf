resource "routeros_ip_firewall_addr_list" "local" {
  list    = "local"
  address = "172.16.31.0/24"
  comment = "Local Network"
}

resource "routeros_routing_bgp_connection" "internal" {
  for_each = {
    core        = "169.254.255.1"
    minicluster = "169.254.255.2"
    bag-bcm     = "169.254.255.4"
    sneakynet   = "169.254.255.6"
    minitel     = "169.254.255.7"
  }

  as   = 64579
  name = each.key

  connect = true
  listen  = true

  cluster_id = "169.254.255.1"
  router_id  = "169.254.255.5"

  hold_time      = "30s"
  keepalive_time = "10s"

  local {
    role    = "ibgp"
    address = "169.254.255.5"
  }

  remote {
    address = each.value
  }

  output {
    default_originate = "if-installed"
    redistribute      = "connected"
    network           = "local"
  }
}
