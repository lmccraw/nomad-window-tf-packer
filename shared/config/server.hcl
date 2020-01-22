data_dir = "C:\\nomad\\data"
log_level = "DEBUG"
enable_debug = "true"

telemetry {
  collection_interval        = "1s"
  publish_allocation_metrics = true
  publish_node_metrics       = true
  prometheus_metrics         = true
  disable_hostname           = true
}

server {
  enabled = true
  bootstrap_expect = 1
}