output "vpc_id" { value = aws_vpc.main.id }
output "public_subnet_ids" { value = aws_subnet.public[*].id }
output "private_subnet_ids" { value = aws_subnet.private[*].id }
output "db_subnet_ids" { value = aws_subnet.database[*].id }

output "web_alb_sg_id" { value = aws_security_group.web_alb.id }
output "web_instance_sg_id" { value = aws_security_group.web_instance.id }
output "app_alb_sg_id" { value = aws_security_group.app_alb.id }
output "app_instance_sg_id" { value = aws_security_group.app_instance.id }
output "db_sg_id" { value = aws_security_group.db.id }