resource "linode_instance" "morning_monitoring" {
  image           = var.linode_image
  label           = var.linode_label
  group           = var.linode_group
  region          = var.linode_region
  type            = var.linode_type
  root_pass       = var.linode_root_pass
  authorized_keys = [var.linode_authorized_keys]
}

locals {
  machine_names = [for name in linode_instance.morning_monitoring.*.label : name]
  machine_ip    = [for ip in linode_instance.morning_monitoring.*.ip_address : ip]
}

# Create a host file for ansible to use
resource "local_file" "file" {
  content  = <<EOT
%{for ip in linode_instance.morning_monitoring.*.ip_address}
[${local.machine_names[index(local.machine_ip, ip)]}]
${ip}
%{endfor}
EOT
  filename = "inventory"
}