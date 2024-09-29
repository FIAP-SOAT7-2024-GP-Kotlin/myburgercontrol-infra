provider "digitalocean" {
  token = var.do_token
}

# provider "kubernetes" {
#   config_path = "~/.kube/config"
#   host        = digitalocean_kubernetes_cluster.my_burger_kubernetes_cluster.endpoint
# }