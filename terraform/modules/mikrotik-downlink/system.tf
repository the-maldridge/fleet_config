resource "routeros_system_identity" "identity" {
  name = var.hostname
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
