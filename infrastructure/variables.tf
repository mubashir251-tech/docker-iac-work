variable "container_name" {
  description = "Name of the Terraform-managed Nginx container"
  type        = string
  default     = "terraform-managed-nginx"
}

variable "external_port" {
  description = "Host port exposed by the Nginx container"
  type        = number
  default     = 8081
}

variable "nginx_image" {
  description = "Nginx Docker image"
  type        = string
  default     = "nginx:alpine"
}

variable "web_replicas" {
  description = "Number of Terraform-managed web containers"
  type        = number
  default     = 2
}
