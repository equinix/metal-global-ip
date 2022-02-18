output "global-ip" {
  description = "Global IP"
  value       = metal_reserved_ip_block.global_ip.network
}

output "eu-ip" {
  description = "EU IP"
  value       = metal_device.device_eu.access_public_ipv4
}

output "us-ip" {
  description = "US IP"
  value       = metal_device.device_us.access_public_ipv4
}

output "eu-test-ip" {
  description = "EU test IP"
  value       = metal_device.device_eu_test.access_public_ipv4
}

output "us-test-ip" {
  description = "US test IP"
  value       = metal_device.device_us_test.access_public_ipv4
}
