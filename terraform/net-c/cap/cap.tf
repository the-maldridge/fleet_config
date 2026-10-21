module "config" {
  source          = "../../modules/mikrotik-cap"
  hostname        = "cap1"
  capsman_address = "172.16.35.1"

  switch_ports = {
    "ether2" = { untagged = 15 }
    "ether3" = { untagged = 15 }
    "ether4" = { untagged = 15 }
    "ether5" = { untagged = 15 }
  }
}
