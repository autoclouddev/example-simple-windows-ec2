output "ip_address" {
  description = "IP address of generated EC2 instance"
  value       = join("", {{ ip_address }}[*])
}
