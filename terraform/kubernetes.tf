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

resource "kubernetes_service" "myburger_load_balancer" {
  metadata {
    name = "myburger"
  }
  spec {
    selector = {
      app = "myburger"
    }
    port {
      port        = 8080
      target_port = 8080
      node_port   = 30001
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_deployment_v1" "myburger_deployment" {
  metadata {
    name = "myburger"
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        test = "myburger"
      }
    }

    template {
      metadata {
        labels = {
          test = "myburger"
        }
      }

      spec {
        container {
          image = "fiapmyburguer/myburgercontrol-clean-arch"
          name  = "myburger"

          resources {
            limits = {
              cpu    = "800m"
              memory = "800Mi"
            }
            requests = {
              cpu    = "600m"
              memory = "512Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/api/v1/actuator/health/liveness"
              port = 8080
            }

            initial_delay_seconds = 90
            period_seconds        = 10
            failure_threshold     = 5
          }

          readiness_probe {
            http_get {
              path = "/api/v1/actuator/health/readiness"
              port = 8080
            }

            initial_delay_seconds = 90
            period_seconds        = 10
            failure_threshold     = 5
          }
        }
      }
    }
  }
}

resource "kubernetes_config_map_v1" "myburger_config" {
  metadata {
    name = "myburger-config"
  }

  data = {
    JAVA_OPTS    = "-server -XX:+UseContainerSupport -XX:+UseParallelGC -XX:MaxRAMPercentage=70.0 -XX:ActiveProcessorCount=1600 -XX:+CrashOnOutOfMemoryError -Xlog:gc"
    DATABASE_URL = "postgresql://postgres:5432/my_burger"
    WIREMOCK_URL = "http://wiremock:8080/mercadopago/pagamento"
    LOG_LEVEL    = "DEBUG"
  }
}
