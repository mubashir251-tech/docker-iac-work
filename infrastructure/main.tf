terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "nginx" {
  name         = var.nginx_image
  keep_locally = true
}

resource "docker_container" "terraform_nginx" {
  name  = var.container_name
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = var.external_port
  }

  restart = "unless-stopped"
}

resource "docker_container" "web" {
  count = var.web_replicas

  name  = "terraform-web-${count.index + 1}"
  image = "docker-iac-web:latest"

  ports {
    internal = 5000
    external = 8100 + count.index
  }

  env = [
    "ENVIRONMENT=terraform"
  ]

  restart = "unless-stopped"
}
