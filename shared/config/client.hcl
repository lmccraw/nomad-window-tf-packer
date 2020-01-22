data_dir = "C:\\nomad\\client"
log_level = "DEBUG"
enable_debug = "true"

name = "client1"

telemetry {
  collection_interval        = "1s"
  publish_allocation_metrics = true
  publish_node_metrics       = true
  prometheus_metrics         = true
  disable_hostname           = true
}

client {
  enabled = true
  servers = ["127.0.0.1:4647"]
  options {
    "driver.raw_exec.enable" = "1"
    "docker.privileged.enabled" = "true"
  }
}
ports {
    http = 5656
}