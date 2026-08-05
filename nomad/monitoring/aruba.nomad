variable "datacenter" {
  type    = string
  default = "SNEAK"
}

variable "targets" {
  type = list(string)
  default = [
    "switch0.sneaky.nonroutable.network",
    "idf01.sneaky.nonroutable.network",
    "aruba00.sneaky.nonroutable.network",
    "aruba01.sneaky.nonroutable.network",
    "aruba02.sneaky.nonroutable.network",
    "aruba03.sneaky.nonroutable.network",
    "aruba04.sneaky.nonroutable.network",
    "aruba05.sneaky.nonroutable.network",
    "aruba06.sneaky.nonroutable.network",
    "aruba07.sneaky.nonroutable.network",
    "aruba08.sneaky.nonroutable.network",
    "aruba09.sneaky.nonroutable.network",
  ]
}

variable "comma" {
  type    = string
  default = ","
}

job "aruba_exporter" {
  type        = "service"
  datacenters = [var.datacenter]

  group "exporter" {
    count = 1

    network {
      mode = "bridge"
      port "http" { to = 9909 }
    }

    service {
      name     = "aruba-exporter"
      port     = "http"
      provider = "nomad"
      tags     = ["prometheus.enable=true"]
    }

    task "exporter" {
      driver = "docker"

      config {
        image   = "aruba_exporter:fc927dd"
        init    = true
        command = "/go/aruba_exporter/aruba_exporter"
        args = [
          "-ssh.user=monitor",
          "-ssh.password=${SSH_PASSWORD}",
          "-ssh.targets=${join(var.comma, var.targets)}",
        ]
      }

      template {
        data        = <<EOT
SSH_PASSWORD={{ with nomadVar "nomad/jobs/aruba_exporter/exporter/exporter" }}{{ .password }}{{ end }}
EOT
        destination = "secrets/env"
        env         = true
      }
    }
  }
}
