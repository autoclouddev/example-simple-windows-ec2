output "ip_address" {
  description = "IP address of generated EC2 instance"
  value       = join("", module.wec2instance-cll744b8k1787083qlt7jqfaq.private_ip[*])
}
