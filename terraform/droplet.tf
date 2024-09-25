resource "digitalocean_droplet" "my_burger" {
  image    = "docker-20-04"
  name     = "my-burger-api-gtw"
  region   = "nyc3"
  size     = "s-1vcpu-1gb"
  vpc_uuid = var.vpc_id
}