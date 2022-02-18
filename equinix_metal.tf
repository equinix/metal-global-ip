data "template_file" "user_data_eu" {
  template = file("user_data_eu.sh")
  vars = {
   GLOBAL_CIDR  = metal_reserved_ip_block.global_ip.cidr_notation
   GLOBAL_IP    = metal_reserved_ip_block.global_ip.network
   TOKEN        = var.metal_token
  }
}

data "template_file" "user_data_us" {
  template = file("user_data_us.sh")
  vars = {
   GLOBAL_CIDR  = metal_reserved_ip_block.global_ip.cidr_notation
   GLOBAL_IP    = metal_reserved_ip_block.global_ip.network
   TOKEN        = var.metal_token
  }
}

resource "metal_reserved_ip_block" "global_ip" {
  project_id = var.project_id
  type       = "global_ipv4"
  quantity   = 1
}

resource "metal_device" "device_eu" {
  hostname         = format("%s-GIP-eu-web",var.customer_name)
  plan             = var.metal_device_size
  metro            = var.metro_eu
  operating_system = var.metal_device_os
  user_data        = data.template_file.user_data_eu.rendered
  billing_cycle    = var.metal_billing_cycle
  project_id       = var.project_id
}

resource "metal_device" "device_us" {
  hostname         = format("%s-GIP-us-web",var.customer_name)
  plan             = var.metal_device_size
  metro            = var.metro_us
  operating_system = var.metal_device_os
  user_data        = data.template_file.user_data_us.rendered
  billing_cycle    = var.metal_billing_cycle
  project_id       = var.project_id
}

resource "metal_device" "device_eu_test" {
  hostname         = format("%s-GIP-eu-test",var.customer_name)
  plan             = var.metal_device_size
  metro            = var.metro_eu
  operating_system = var.metal_device_os
  billing_cycle    = var.metal_billing_cycle
  project_id       = var.project_id
}

resource "metal_device" "device_us_test" {
  hostname         = format("%s-GIP-us-test",var.customer_name)
  plan             = var.metal_device_size
  metro            = var.metro_us
  operating_system = var.metal_device_os
  billing_cycle    = var.metal_billing_cycle
  project_id       = var.project_id
}

resource "metal_ip_attachment" "assignment_eu" {
  device_id = metal_device.device_eu.id
  cidr_notation = join("/", [cidrhost(metal_reserved_ip_block.global_ip.cidr_notation, 0), "32"])
} 

resource "metal_ip_attachment" "assignment_us" {
  device_id = metal_device.device_us.id
  cidr_notation = join("/", [cidrhost(metal_reserved_ip_block.global_ip.cidr_notation, 0), "32"])

}
