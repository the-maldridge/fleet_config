resource "routeros_system_identity" "identity" {
  name = var.hostname
}

resource "routeros_ip_dns" "dns" {
  allow_remote_requests = true
  servers               = var.dns_servers
}

resource "routeros_ip_service" "disabled" {
  for_each = {
    api-ssl = 8729
    ftp     = 21
    telnet  = 21
    winbox  = 8291
    www     = 80
  }

  numbers  = each.key
  port     = each.value
  disabled = true
}

resource "routeros_system_ntp_client" "client" {
  enabled = true
  mode    = "unicast"
  servers = var.ntp_servers
}

resource "routeros_system_ntp_server" "server" {
  enabled             = true
  use_local_clock     = true
  local_clock_stratum = 5
}
