variable "datacenter" {
  type    = string
  default = "SNEAK"
}

job "prometheus" {
  datacenters = [var.datacenter]
  type        = "service"

  group "app" {
    count = 1

    volume "prometheus" {
      type      = "host"
      read_only = false
      source    = "prometheus_data"
    }

    network {
      mode = "bridge"
      port "http" { static = 9090 }
    }

    service {
      name     = "prometheus"
      provider = "nomad"
      port     = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.prometheus.entrypoints=mgmt",
      ]
    }

    task "prometheus" {
      driver = "docker"

      identity {
        file = true
      }

      config {
        image = "docker.io/prom/prometheus:v3.4.0"
        args = [
          "--config.file=/local/prometheus.yml",
          "--storage.tsdb.path=/prometheus",
          "--web.console.libraries=/usr/share/prometheus/console_libraries",
          "--web.console.templates=/usr/share/prometheus/consoles"
        ]
      }

      resources {
        cpu    = 500
        memory = 400
      }

      volume_mount {
        volume      = "prometheus"
        destination = "/prometheus"
        read_only   = false
      }

      template {
        data = yamlencode({
          global = {
            scrape_interval     = "30s"
            evaluation_interval = "30s"
            scrape_timeout      = "30s"
          }

          scrape_configs = [{
            job_name = "prometheus"
            static_configs = [{
              targets = ["localhost:9090"]
            }]
            }, {
            job_name = "nomad"
            nomad_sd_configs = [{
              server        = "http://172.26.64.1:4646"
              region        = "global"
              namespace     = "default"
              authorization = { credentials_file = "/secrets/nomad_token" }
            }]
            relabel_configs = [{
              source_labels = ["__meta_nomad_tags"]
              regex         = ".*,prometheus.enable=true,.*"
              action        = "keep"
              }, {
              source_labels = ["__meta_nomad_tags"]
              regex         = ".*,prometheus.path=(.*),.*"
              replacement   = "$1"
              target_label  = "__metrics_path__"
              }, {
              source_labels = ["__meta_nomad_service"]
              target_label  = "job"
              }, {
              source_labels = ["__meta_nomad_tags"]
              regex         = ".*,prometheus.job=(.*),.*"
              target_label  = "job"
              }, {
              source_labels = ["__meta_nomad_namespace"]
              target_label  = "namespace"
              }, {
              source_labels = ["__meta_nomad_dc"]
              target_label  = "datacenter"
            }]
          }]
        })
        destination   = "local/prometheus.yml"
        perms         = 644
        change_mode   = "signal"
        change_signal = "SIGHUP"
      }
    }
  }
}
