output "website_url" {
  value = "http://${module.web.alb_dns}"
}

output "db_endpoint" {
  value = module.database.db_endpoint
}

output "db_secret_arn" {
  value = module.database.db_secret_arn
}