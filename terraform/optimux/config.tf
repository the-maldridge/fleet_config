module "switch" {
  source = "../modules/mikrotik-switch"

  hostname = "optimux"

  trunks = ["combo1"]

  ports = {
    mgmt = formatlist("sfp%d", [1, 2, 3, 4, 5])
  }
}
