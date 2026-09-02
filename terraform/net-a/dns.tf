module "supplemental_dns" {
  source = "../modules/mikrotik-dns"

  default_zone = "vcf"

  records = {
    "10.8.2.1"     = ["OAKSPAEXRT0.shadytel"]
    "10.8.2.2"     = ["OAKSPAEXDS0.shadytel"]
    "172.23.255.2" = ["LBRDILGF00T.shadytel"]
    "172.24.255.3" = ["SCBGILCS01T.shadytel"]
    "172.24.0.8"   = ["SCBGILCSAM0.shadytel"]
    "172.24.0.3"   = ["SCBGILCSCM0.shadytel"]
    "172.24.1.2"   = ["SCBGILCSDS0.shadytel", "SCBGILCNRS0.shadytel"]
    "172.24.255.5" = ["SCBGILCSDS1.shadytel"]
    "172.24.0.2"   = ["SCBGILCSPS0.shadytel"]
    "172.24.0.1"   = ["SCBGILCSRT0.shadytel"]
    "172.24.5.1"   = ["SCBGILCSRT1.shadytel"]
    "172.24.0.9"   = ["SCBGILCNAM0.shadytel"]
    "172.16.34.5"  = ["SCBGILCSDS2.shadytel"]

    "172.24.3.11" = ["icm"]
    "172.24.3.12" = ["chicagotiug"]
    "172.24.3.13" = ["veronicaexplains"]
    "172.24.9.20" = ["vaxai"]
    "172.24.9.95" = ["vaxarcade"]

    "172.24.8.2" = [
      "aim.millennia",
      "login.oscar.aol.com.",
      "aim-charts.pf.aol.com.",
      "quotewebvip-m01.blue.aol.com.",
      "charts.netscape.com.",
    ]
    "172.24.8.3" = ["www.millennia"]
  }
}
