output "instance_ip_addr" {
  value       = aws_instance.instance-pub.public_ip
  description = "The public IP address of the public server instance."
}

