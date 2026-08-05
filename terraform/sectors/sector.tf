module "config" {
  source          = "../modules/mikrotik-cap"
  hostname        = terraform.workspace
  capsman_address = "172.16.34.1"
}
