
#resource "aws_key_pair" "frontend-key-deployer" {
#  key_name   = var.aws_key_name
#  public_key = var.aws_public_key
#}

data "aws_vpc" "default" {
  default = true
}


# resource "aws_eip_association" "frontend_association_EIP" {
#   instance_id   = aws_instance.frontend_instance.id
#   allocation_id = var.aws_allocation_id
# }

resource "aws_instance" "monitoring_instance" {
  ami                    = var.aws_ami
  instance_type          = var.aws_instance_type
  vpc_security_group_ids = [aws_security_group.monitoring_security_group.id]
  key_name               = var.aws_key_name

  tags = {
    Name = var.aws_monitoring_instance_name
  }
}

resource "aws_security_group" "monitoring_security_group" {
  name   = var.aws_security_group_name
  vpc_id = data.aws_vpc.default.id

  ingress = [
    for port in [22, 80, 443, 9090, 9093, 9100, 8081] : {
      description      = "TLS from VPC"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create lists that contain the names and IP adress of the created machines
locals {
  machine_names = [for name in aws_instance.monitoring_instance.*.tags.Name : name]
  machine_ip    = [for ip in aws_instance.monitoring_instance.*.public_ip : ip]
}

# Create a file with the Machine Names and their associated Public IP adresses
resource "local_file" "file" {
  content  = <<EOT
%{for ip in aws_instance.monitoring_instance.*.public_ip}
[${local.machine_names[index(local.machine_ip, ip)]}]
${ip}
%{endfor}
EOT
  filename = "inventory"
}