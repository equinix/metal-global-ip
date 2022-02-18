variable "metal_token" {
  type        = string
  description = "Equinix Metal Token API"
}

variable "organization_id" {
  type        = string
  description = "Equinix Metal Organization ID"
}

variable "project_id" {
  type        = string
  description = "Equinix Metal Project ID"
}

variable "metro_us" {
  type        = string
  description = "Equinix Metal US facility to deploy into"
}

variable "metro_eu" {
  type        = string
  description = "Equinix Metal EU facility to deploy into"
}

variable "metal_device_os" {
  type        = string
  description = "The Operating system of the node"
}

variable "customer_name" {
  type        = string
  description = "Include the name of the customer to customize the demo"
}

variable "metal_device_size" {
  type        = string
  description = "Equinix Metal device type"
}

variable "metal_billing_cycle" {
  type        = string
  description = "How the node will be billed (usually hourly)"
}

