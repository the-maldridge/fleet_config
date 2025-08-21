resource "routeros_interface_wireless_security_profiles" "wireless" {
  name                 = "downlink"
  mode                 = (var.network_security_mode == "WPA") ? "dynamic-keys" : "none"
  authentication_types = ["wpa-psk", "wpa2-psk"]
  wpa_pre_shared_key   = var.network_psk
  wpa2_pre_shared_key  = var.network_psk
}

resource "routeros_interface_wireless" "wireless" {
  depends_on       = [resource.routeros_interface_wireless_security_profiles.wireless]
  security_profile = resource.routeros_interface_wireless_security_profiles.wireless.name
  mode             = "station-pseudobridge"
  name             = "wlan1"
  ssid             = var.network_ssid
  band             = var.network_band
}

