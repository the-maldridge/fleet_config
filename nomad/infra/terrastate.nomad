variable "datacenter" {
  type    = string
  default = "SNEAK"
}

job "terrastate" {
  type        = "service"
  datacenters = [var.datacenter]

  group "terrastate" {
    count = 1

    network {
      mode = "bridge"
      port "http" {
        static = 8085
        to     = 8080
      }
    }

    volume "terrastate_data" {
      type      = "host"
      read_only = false
      source    = "terrastate_data"
    }

    volume "netauth_config" {
      type      = "host"
      read_only = true
      source    = "netauth_config"
    }

    service {
      name     = "terrastate"
      port     = "http"
      provider = "nomad"

      check {
        type         = "http"
        address_mode = "host"
        path         = "/healthz"
        timeout      = "30s"
        interval     = "15s"
      }
    }

    task "app" {
      driver = "docker"

      config {
        image = "ghcr.io/the-maldridge/terrastate:v1.2.3"
        init  = true
      }

      env {
        AUTHWARE_BASIC_MECHS = "netauth"
        TS_AUTH_PREFIX       = "terrastate-"
        TS_BITCASK_PATH      = "/data"
        TS_STORE             = "bitcask"
      }

      volume_mount {
        volume      = "terrastate_data"
        destination = "/data"
        read_only   = false
      }

      volume_mount {
        volume      = "netauth_config"
        destination = "/etc/netauth"
        read_only   = true
      }
    }
  }
}
