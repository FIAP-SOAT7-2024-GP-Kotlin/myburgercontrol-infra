resource "digitalocean_database_db" "myburger_database" {
  cluster_id = digitalocean_database_cluster.myburger_database_cluster.id
  name       = "myburger-db-server"
}

resource "digitalocean_database_cluster" "myburger_database_cluster" {
  name       = "myburger-db-server"
  engine     = "pg"
  version    = "16"
  size       = "db-s-1vcpu-1gb"
  region     = "nyc3"
  node_count = 1
}