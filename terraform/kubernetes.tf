resource "digitalocean_kubernetes_cluster" "my_burger_kubernetes_cluster" {
  name   = "my-burger-k8s"
  region = "nyc3"
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.22.8-do.1"

  node_pool {
    name       = "my-burger-node-pool"
    size       = "s-1vcpu-2gb"
    node_count = 1
    auto_scale = true
    min = 1
    max = 3
    vpc_uuid = var.vpc_id

    taint {
      key    = "workloadKind"
      value  = "database"
      effect = "NoSchedule"
    }
  }
}