static_hosts = {
  switch0 = {
    mac  = "E0:07:1B:97:15:A0"
    addr = "172.16.34.2"
  }

  sneakypizza = {
    mac  = "00:25:90:f4:92:a0"
    addr = "172.16.34.3"
    cname = [
      "files",
      "netauth",
      "traefik",
    ]
  }

  sneakypizza-lan = {
    mac    = "02:00:00:00:00:00"
    addr   = "100.64.10.2"
    server = "lan"
  }

  sneakypizza-trust = {
    mac    = "02:01:00:00:00:00"
    addr   = "100.64.16.2"
    server = "trust"
  }

  sneaky-oob = {
    mac  = "00:25:90:f6:b4:82"
    addr = "172.16.34.4"
  }

  cme00 = {
    mac  = "00:1a:a1:9f:99:60"
    addr = "172.16.34.5"
  }

  ups0 = {
    mac  = "28:29:86:42:DF:0F"
    addr = "172.16.34.6"
  }

  idf01 = {
    mac  = "D0:67:26:16:4F:E0"
    addr = "172.16.34.7"
  }

  icx00 = {
    mac  = "D4:C1:9E:8C:10:94"
    addr = "172.16.34.10"
  }

  icx01 = {
    mac  = "D4:C1:9E:88:D6:7A"
    addr = "172.16.34.11"
  }

  icx02 = {
    mac  = "D4:C1:9E:8C:02:BA"
    addr = "172.16.34.12"
  }

  icx03 = {
    mac  = "D4:C1:9E:87:FC:70"
    addr = "172.16.34.13"
  }

  icx04 = {
    mac  = "D4:C1:9E:8C:20:E4"
    addr = "172.16.34.14"
  }

  icx05 = {
    mac  = "D4:C1:9E:89:C1:D0"
    addr = "172.16.34.15"
  }

  icx06 = {
    mac  = "D4:C1:9E:8C:01:AC"
    addr = "172.16.34.16"
  }

  fleet00 = {
    mac  = "e4:42:a6:19:ec:13"
    addr = "172.16.34.50"
  }

  fleet01 = {
    mac  = "c8:21:58:11:1c:af"
    addr = "172.16.34.51"
  }

  fleet02 = {
    mac  = "c8:21:58:56:1c:06"
    addr = "172.16.34.52"
  }

  fleet03 = {
    mac  = "c8:21:58:06:99:dd"
    addr = "172.16.34.53"
  }

  fleet04 = {
    mac  = "c8:21:58:0b:12:42"
    addr = "172.16.34.54"
  }

  fleet05 = {
    mac  = "c8:21:58:87:4b:d2"
    addr = "172.16.34.55"
  }

  fleet06 = {
    mac  = "c8:21:58:0d:7d:61"
    addr = "172.16.34.56"
  }

  fleet07 = {
    mac  = "c8:21:58:09:67:99"
    addr = "172.16.34.57"
  }

  fleet08 = {
    mac  = "c8:21:58:07:23:17"
    addr = "172.16.34.58"
  }

  fleet09 = {
    mac  = "c8:21:58:56:96:09"
    addr = "172.16.34.59"
  }

  fleet10 = {
    mac  = "c8:21:58:07:23:da"
    addr = "172.16.34.60"
  }

  fleet11 = {
    mac  = "c8:21:58:11:1c:41"
    addr = "172.16.34.61"
  }

  fleet12 = {
    mac  = "c8:21:58:02:8f:73"
    addr = "172.16.34.62"
  }

  fleet13 = {
    mac  = "c8:21:58:0d:74:56"
    addr = "172.16.34.63"
  }

  fleet14 = {
    mac  = "5c:5f:67:5d:76:fe"
    addr = "172.16.34.64"
  }

  fleet15 = {
    mac  = "5c:5f:67:48:7a:c4"
    addr = "172.16.34.65"
  }

  fleet16 = {
    mac  = "e4:42:a6:7b:07:28"
    addr = "172.16.34.66"
  }

  fleet17 = {
    mac  = "e4:42:a6:72:e2:cd"
    addr = "172.16.34.67"
  }

  fleet-media-a = {
    mac  = "e4:42:a6:a8:78:ac"
    addr = "172.16.34.70"
  }

  fleet-media-b = {
    mac  = "1c:4d:70:7e:3e:ed"
    addr = "172.16.34.71"
  }

  aruba00 = {
    mac  = "00:4e:35:c4:3d:28"
    addr = "172.16.34.80"
  }

  aruba01 = {
    mac  = "00:4e:35:c4:3d:b4"
    addr = "172.16.34.81"
  }

  aruba02 = {
    mac  = "00:4e:35:c4:40:76"
    addr = "172.16.34.82"
  }

  aruba03 = {
    mac  = "00:4e:35:c4:42:4e"
    addr = "172.16.34.83"
  }

  aruba04 = {
    mac  = "20:a6:cd:c6:f7:3c"
    addr = "172.16.34.84"
  }

  aruba05 = {
    mac  = "20:a6:cd:c8:2c:c6"
    addr = "172.16.34.85"
  }

  aruba06 = {
    mac  = "20:a6:cd:c8:2e:22"
    addr = "172.16.34.86"
  }

  aruba07 = {
    mac  = "20:a6:cd:c8:2e:24"
    addr = "172.16.34.87"
  }

  aruba08 = {
    mac  = "20:a6:cd:c8:2e:2c"
    addr = "172.16.34.88"
  }

  aruba09 = {
    mac  = "7c:57:3c:c4:97:e4"
    addr = "172.16.34.89"
  }

  aruba10 = {
    mac  = "20:a6:cd:c9:30:38"
    addr = "172.16.34.90"
  }

  aruba11 = {
    mac  = "20:a6:cd:c9:30:72"
    addr = "172.16.34.91"
  }

  aruba12 = {
    mac  = "80:8d:b7:c5:ce:7c"
    addr = "172.16.34.92"
  }

  gigacast-oob = {
    mac    = "9C:6B:00:C3:9C:68"
    addr   = "172.16.34.8"
  }

  gigacast = {
    mac    = "9c:6b:00:c3:93:7a"
    addr   = "192.0.2.8"
    server = "media"
  }

  birdkbd0 = {
    mac    = "20:32:33:ab:1b:f1"
    addr   = "192.0.2.9"
    server = "media"
  }

  bird0 = {
    mac    = "80:1F:12:F7:7E:0C"
    addr   = "192.0.2.10"
    server = "media"
  }

  bird1 = {
    mac    = "80:1f:12:37:71:e9"
    addr   = "192.0.2.11"
    server = "media"
  }

  bird2 = {
    mac    = "80:1f:12:37:1c:e8"
    addr   = "192.0.2.12"
    server = "media"
  }
}
