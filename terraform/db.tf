resource "digitalocean_database_db" "my_burger_database" {
  cluster_id = digitalocean_database_cluster.myburger_database_cluster.id
  name       = "my_burger"
}

resource "digitalocean_database_cluster" "myburger_database_cluster" {
  name       = "myburger-db-server"
  engine     = "pg"
  version    = "16"
  size       = "db-s-1vcpu-1gb"
  region     = "nyc1"
  node_count = 1
}

resource "time_sleep" "db_ready" {
  create_duration = "60s"
  depends_on      = [digitalocean_database_db.my_burger_database]

  provisioner "local-exec" {
    command = "echo \"Waiting for database to be ready...\""
  }
}