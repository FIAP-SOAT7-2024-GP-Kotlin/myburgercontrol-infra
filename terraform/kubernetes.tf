resource "digitalocean_kubernetes_cluster" "my_burger_kubernetes_cluster" {
  name     = "my-burger-k8s"
  region   = "nyc1"
  version  = "1.31.1-do.0"
  vpc_uuid = var.vpc_id

  node_pool {
    name       = "my-burger-node-pool"
    size       = "s-2vcpu-4gb"
    node_count = 1
    auto_scale = true
    min_nodes  = 1
    max_nodes  = 3
  }
}