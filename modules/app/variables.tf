variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "app_alb_sg_id" {
  type = string
}

variable "app_instance_sg_id" {
  type = string
}

variable "db_secret_arn" {
  type = string
}
