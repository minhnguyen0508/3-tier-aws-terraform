variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "web_alb_sg_id" {
  type = string
}

variable "web_instance_sg_id" {
  type = string
}

variable "app_alb_dns" {
  type = string
}