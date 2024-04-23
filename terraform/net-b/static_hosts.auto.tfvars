static_hosts = {
  switch0 = {
    mac  = "00:87:31:43:E6:02"
    addr = "172.16.31.2"
  }

  sneakyserv = {
    mac  = "10:e7:c6:05:92:a2"
    addr = "172.16.31.3"

    cname = [
      "traefik",
      "files",
      "pitman",
      "nomad",
      "prometheus",
      "grafana",
    ]
  }

  sneakynet-00 = {
    addr = "172.16.31.10"
    mac  = "18:64:72:c7:a7:0a"
  }

  sneakynet-01 = {
    addr = "172.16.31.11"
    mac  = "18:64:72:c7:a7:36"
  }

  sneakynet-02 = {
    addr = "172.16.31.12"
    mac  = "18:64:72:c7:a7:3e"
  }

  sneakynet-03 = {
    addr = "172.16.31.13"
    mac  = "18:64:72:c7:a7:72"
  }

  sneakynet-04 = {
    addr = "172.16.31.14"
    mac  = "18:64:72:c7:a7:90"
  }

  sneakynet-05 = {
    addr = "172.16.31.15"
    mac  = "18:64:72:c7:a8:32"
  }

  sneakynet-06 = {
    addr = "172.16.31.16"
    mac  = "18:64:72:c7:a8:64"
  }

  sneakynet-07 = {
    addr = "172.16.31.17"
    mac  = "18:64:72:c7:a8:6a"
  }

  sneakynet-08 = {
    addr = "172.16.31.18"
    mac  = "18:64:72:c9:a7:94"
  }

  sneakynet-09 = {
    addr = "172.16.31.19"
    mac  = "18:64:72:c9:a7:b4"
  }

  sneakynet-10 = {
    addr = "172.16.31.20"
    mac  = "18:64:72:c9:a7:bc"
  }

  sneakynet-11 = {
    addr = "172.16.31.21"
    mac  = "18:64:72:c9:a7:d2"
  }

  sneakynet-12 = {
    addr = "172.16.31.22"
    mac  = "18:64:72:c9:b4:a6"
  }

  sneakynet-13 = {
    addr = "172.16.31.23"
    mac  = "18:64:72:c9:b4:b2"
  }

  sneakynet-14 = {
    addr = "172.16.31.24"
    mac  = "18:64:72:ca:55:18"
  }

  sneakynet-15 = {
    addr = "172.16.31.25"
    mac  = "18:64:72:ca:55:a8"
  }

  sneakynet-16 = {
    addr = "172.16.31.26"
    mac  = "18:64:72:cc:8f:70"
  }

  sneakynet-17 = {
    addr = "172.16.31.27"
    mac  = "18:64:72:cc:9a:44"
  }

  sneakynet-18 = {
    addr = "172.16.31.28"
    mac  = "18:64:72:cc:9a:90"
  }

  sneakynet-19 = {
    addr = "172.16.31.29"
    mac  = "18:64:72:cc:9b:0c"
  }

  sneakynet-20 = {
    addr = "172.16.31.30"
    mac  = "44:48:c1:c5:d5:bc"
  }

  sneakynet-21 = {
    addr = "172.16.31.31"
    mac  = "44:48:c1:c5:d6:2c"
  }

  sneakynet-22 = {
    addr = "172.16.31.32"
    mac  = "44:48:c1:c5:d6:8e"
  }

  sneakynet-23 = {
    addr = "172.16.31.33"
    mac  = "44:48:c1:c5:d6:e2"
  }

  sneakynet-24 = {
    addr = "172.16.31.34"
    mac  = "44:48:c1:c5:d7:4e"
  }

  sneakynet-25 = {
    addr = "172.16.31.35"
    mac  = "44:48:c1:c5:ae:50"
  }

  sneakynet-26 = {
    addr = "172.16.31.36"
    mac  = "44:48:c1:c5:f1:e4"
  }

  sneakynet-27 = {
    addr = "172.16.31.37"
    mac  = "ac:a3:1e:c7:d3:2c"
  }

  sneakynet-28 = {
    addr = "172.16.31.38"
    mac  = "ac:a3:1e:c8:22:70"
  }

  sneakynet-29 = {
    addr = "172.16.31.39"
    mac  = "ac:a3:1e:c8:22:74"
  }

  sneakynet-30 = {
    addr = "172.16.31.40"
    mac  = "ac:a3:1e:c8:22:7c"
  }

  sneakynet-31 = {
    addr = "172.16.31.41"
    mac  = "ac:a3:1e:c8:22:7e"
  }

  sneakynet-32 = {
    addr = "172.16.31.42"
    mac  = "ac:a3:1e:c8:22:8e"
  }

  sneakynet-33 = {
    addr = "172.16.31.43"
    mac  = "ac:a3:1e:c8:24:b4"
  }

  sneakynet-34 = {
    addr = "172.16.31.44"
    mac  = "ac:a3:1e:c8:24:e8"
  }

  sneakynet-35 = {
    addr = "172.16.31.45"
    mac  = "ac:a3:1e:c8:25:02"
  }

  sneakynet-36 = {
    addr = "172.16.31.46"
    mac  = "ac:a3:1e:c8:ed:9a"
  }

  fleet00 = {
    mac  = "e4:42:a6:19:ec:13"
    addr = "172.16.31.50"
  }

  fleet01 = {
    mac  = "c8:21:58:11:1c:af"
    addr = "172.16.31.51"
  }

  fleet02 = {
    mac  = "c8:21:58:56:1c:06"
    addr = "172.16.31.52"
  }

  fleet03 = {
    mac  = "c8:21:58:06:99:dd"
    addr = "172.16.31.53"
  }

  fleet04 = {
    mac  = "c8:21:58:0b:12:42"
    addr = "172.16.31.54"
  }

  fleet05 = {
    mac  = "c8:21:58:87:4b:d2"
    addr = "172.16.31.55"
  }

  fleet06 = {
    mac  = "c8:21:58:0d:7d:61"
    addr = "172.16.31.56"
  }

  fleet07 = {
    mac  = "c8:21:58:09:67:99"
    addr = "172.16.31.57"
  }

  fleet08 = {
    mac  = "c8:21:58:07:23:17"
    addr = "172.16.31.58"
  }

  fleet09 = {
    mac  = "c8:21:58:56:96:09"
    addr = "172.16.31.59"
  }

  fleet10 = {
    mac  = "c8:21:58:07:23:da"
    addr = "172.16.31.60"
  }

  fleet11 = {
    mac  = "c8:21:58:11:1c:41"
    addr = "172.16.31.61"
  }

  fleet12 = {
    mac  = "c8:21:58:02:8f:73"
    addr = "172.16.31.62"
  }

  fleet13 = {
    mac  = "c8:21:58:0d:74:56"
    addr = "172.16.31.63"
  }

  fleet-media-a = {
    mac  = "e4:42:a6:a8:78:ac"
    addr = "172.16.31.70"
  }

  fleet-media-b = {
    mac  = "1c:4d:70:7e:3e:ed"
    addr = "172.16.31.71"
  }

  omnicast = {
    mac  = "a0:36:bc:58:00:92"
    addr = "172.16.31.90"
  }

  light-cannon = {
    mac  = "bc:c3:42:88:79:c4"
    addr = "172.16.31.91"
  }

  droidcam1 = {
    mac  = "e8:d8:7e:c2:fd:2b"
    addr = "172.16.31.92"
  }
}
