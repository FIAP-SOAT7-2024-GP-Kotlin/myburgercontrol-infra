terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.32.0"
      host    = data.digitalocean_kubernetes_cluster.my_burger_kubernetes_cluster
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}