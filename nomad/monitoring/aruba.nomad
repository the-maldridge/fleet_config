variable "datacenter" {
  type = string
  default = "SNEAK"
}

variable "targets" {
  type = list(string)
  default = [
    "switch0", "idf01",
    "aruba00", "aruba01", "aruba02", "aruba03", "aruba04",
    "aruba05", "aruba06", "aruba07", "aruba08", "aruba09",
  ]
}

variable "comma" {
  type = string
  default = ","
}

job "aruba_exporter" {
  type = "service"
  datacenters = [var.datacenter]

  group "exporter" {
    count = 1

    network {
      mode = "bridge"
      port "http" { to = 9909 }
    }

    service {
      name = "aruba-exporter"
      port = "http"
      provider = "nomad"
      tags = ["prometheus.enable=true"]
    }

    task "exporter" {
      driver = "docker"

      config {
        image = "aruba_exporter:ca30cd6"
        init = true
        command = "/go/aruba_exporter/aruba_exporter"
        args = [
          "-ssh.user=monitor",
          "-ssh.password=${SSH_PASSWORD}",
          "-ssh.targets=${join(var.comma, var.targets)}",
        ]
      }

      template {
        data = <<EOT
SSH_PASSWORD={{ with nomadVar "nomad/jobs/aruba_exporter/exporter/exporter" }}{{ .password }}{{ end }}
EOT
        destination = "secrets/env"
        env = true
      }
    }
  }
}
