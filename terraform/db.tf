resource "digitalocean_database_db" "my_burger_database" {
  cluster_id = digitalocean_database_cluster.myburger_database_cluster.id
  name       = "my_burger"
}

resource "digitalocean_database_cluster" "myburger_database_cluster" {
  name       = "myburger-db-server"
  engine     = "pg"
  version    = "16"
  size       = "db-s-1vcpu-1gb"
  region     = "nyc3"
  node_count = 1
}

resource "digitalocean_database_user" "my_burger_user" {
  cluster_id = digitalocean_database_cluster.myburger_database_cluster.id
  name     = "my_burger"
  password = "password"
}