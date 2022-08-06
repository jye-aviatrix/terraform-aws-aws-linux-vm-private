output "instance_id" {
  description = "Instance ID"
  value       = aws_instance.this.id
}


output "private_ip" {
  description = "Private IP"
  value       = aws_instance.this.private_ip
}

output "ssh" {
  description = "A shortcut for ssh command (assuming .pem extension)"
  value       = "ssh -i ${var.key_name}.pem ubuntu@${aws_instance.this.private_ip}"
}