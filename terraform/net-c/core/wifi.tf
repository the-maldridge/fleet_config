variable "wifi" {
  description = "WiFi SSIDs and PSKs"
  type = map(list(object({
    ssid   = string
    band   = optional(list(string), ["5ghz"])
    auth   = optional(list(string), ["wpa2-psk"])
    psk    = string
    hide   = optional(bool, false)
    master = optional(bool, false)
  })))
}

module "capsman" {
  source     = "../../modules/mikrotik-capsman"
  interfaces = [module.router.vlan_names[30]]
  wifi       = var.wifi
  networks   = module.router.vlan_names
  bridge     = module.router.bridge_name
}
