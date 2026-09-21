locals {
  port_config = {
    optimux1 = {
      trunks = flatten(["ether1", formatlist("sfp-sfpplus%d", [1, 2, 3, 4])])
      ports = {}
    }
  }
}

module "switch" {
  source = "../modules/mikrotik-switch"

  hostname = terraform.workspace
  trunks = local.port_config[terraform.workspace].trunks
  ports = local.port_config[terraform.workspace].ports


  additional_vlans = {
    shadytel_mgmt = { id = 500, description = "ShadyTel MGMT" }
    shadytel_ppp = { id = 503, description = "ShadyTel PPPoE" }
  }
}
