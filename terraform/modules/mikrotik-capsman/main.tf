locals {
  ssids = {
    for i in flatten([
      for vlan, vlan_name in var.networks : [
        for cfg in lookup(var.wifi, vlan_name, []) : [
          for band in cfg.band : {
            name     = format("%s-%s", cfg.ssid, band)
            ssid     = cfg.ssid
            psk      = cfg.psk
            authtype = cfg.auth
            band     = band
            hide     = cfg.hide
            master   = cfg.master
            datapath = vlan
          }
        ]
      ]
    ]) : i.name => i
  }
}

output "ssids" {
  value = local.ssids
}

resource "routeros_wifi_capsman" "mgr" {
  enabled        = true
  upgrade_policy = "require-same-version"
  certificate    = "auto"
  ca_certificate = "auto"
  interfaces     = var.interfaces
}

resource "routeros_wifi_channel" "channel" {
  for_each = {
    band-2ghz = { band = "2ghz-n" }
    band-5ghz = { band = "5ghz-ax" }
  }
  name = each.key
  band = each.value.band
}

resource "routeros_wifi_datapath" "datapath" {
  for_each = { for id, net in var.networks : id => net if contains(keys(var.wifi), net) }

  name    = each.value
  vlan_id = each.key
  bridge  = var.bridge
}

resource "routeros_wifi_security" "security" {
  for_each = local.ssids

  name                 = each.key
  authentication_types = each.value.authtype
  passphrase           = each.value.psk
  encryption           = ["ccmp", "ccmp-256", "gcmp", "gcmp-256"]
}

resource "routeros_wifi_configuration" "config" {
  for_each = local.ssids

  name      = each.key
  ssid      = each.value.ssid
  hide_ssid = each.value.hide
  mode      = "ap"
  country   = "United States"

  datapath = {
    config = routeros_wifi_datapath.datapath[each.value.datapath].name
  }

  security = {
    config = routeros_wifi_security.security[each.key].name
  }
}

resource "routeros_wifi_provisioning" "provision_5ghz" {
  action               = "create-dynamic-enabled"
  master_configuration = one([for ssid in local.ssids : ssid.name if(ssid.band == "5ghz" && ssid.master)])
  supported_bands      = ["5ghz-ax"]
  slave_configurations = [for ssid in local.ssids : ssid.name if(ssid.band == "5ghz" && !ssid.master)]
}

resource "routeros_wifi_provisioning" "provision_2ghz" {
  action               = "create-dynamic-enabled"
  master_configuration = one([for ssid in local.ssids : ssid.name if(ssid.band == "2ghz" && ssid.master)])
  supported_bands      = ["2ghz-n"]
  slave_configurations = [for ssid in local.ssids : ssid.name if(ssid.band == "2ghz" && !ssid.master)]
}
