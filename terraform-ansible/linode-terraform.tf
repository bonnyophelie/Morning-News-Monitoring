terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "2.5.2"
    }
  }
}

provider "linode" {
  token = var.token
}

resource "linode_instance" "morning_monitoring" {
  image           = "linode/debian12"
  label           = "Monitoring"
  group           = "Morning News"
  region          = "fr-par"
  type            = "g6-nanode-1"
  root_pass       = var.root_pass
  authorized_keys = [var.authorized_keys]
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
  filename = "host"
}