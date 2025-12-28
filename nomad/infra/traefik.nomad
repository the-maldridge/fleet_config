variable "datacenter" {
  type    = string
  default = "SNEAK"
}

job "traefik" {
  type        = "service"
  datacenters = [var.datacenter]

  group "traefik" {
    count = 1

    network {
      mode = "host"

      port "http" {
        static = 80
      }
      port "admin" {
        static = 9000
      }
    }

    service {
      name     = "traefik"
      provider = "nomad"
      port     = "http"
      tags = [
        "traefik.http.routers.traefik.service=api@internal",
      ]
    }

    task "server" {
      driver = "docker"
      config {
        image        = "docker.io/traefik:v3.5.3"
        network_mode = "host"
        args = [
          "--api.dashboard=true",
          "--api.insecure=true",
          "--entrypoints.mgmt.address=${NOMAD_IP_http}:${NOMAD_PORT_http}",
          "--entrypoints.mgmt.asDefault=true",
          "--entrypoints.lan.address=100.64.16.2:80",
          "--entrypoints.trust.address=100.64.32.2:80",
          "--entrypoints.traefik.address=${NOMAD_IP_admin}:${NOMAD_PORT_admin}",
          "--providers.nomad=true",
          "--providers.nomad.defaultRule=Host(`{{ .Name }}.sneaky.nonroutable.network`)",
          "--providers.nomad.exposedByDefault=false",
        ]
      }
    }
  }
}

