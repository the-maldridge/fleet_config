resource "routeros_system_identity" "identity" {
  name = var.hostname
}

resource "routeros_ip_dns" "dns" {
  allow_remote_requests = true
  servers               = ["8.8.8.8", "8.8.4.4"]
}

resource "routeros_ip_service" "disabled" {
  for_each = {
    api-ssl = 8729
    api     = 8278
    ftp     = 21
    telnet  = 21
    winbox  = 8291
  }

  numbers  = each.key
  port     = each.value
  disabled = true
}

resource "routeros_ip_service" "enabled" {
  for_each = {
    ssh = 22
  }

  numbers = each.key
  port    = each.value
}
