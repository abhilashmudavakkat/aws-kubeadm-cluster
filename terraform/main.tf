resource "aws_key_pair" "ssh_key" {

  key_name   = "${var.project_name}-${var.project_environment}"
  public_key = file("./key.pub")
}

resource "aws_instance" "node" {

  for_each = var.instance_hostnames

  ami                         = var.instance_ami
  instance_type               = var.instance_type
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh_key.key_name
  user_data                   = file("./userdata.sh")
  vpc_security_group_ids      = [aws_security_group.full_access.id]

  root_block_device {

    volume_size = var.root_volume_size
  }

  volume_tags = {

    Name = each.key




  }

  tags = {

    Name     = each.key
    Hostname = each.value
    Role     = strcontains(each.key, "master") ? "master" : "worker"

  }
}

resource "aws_security_group" "full_access" {
 
  name        = "${var.project_name}_full_access"
  description = "Allow all inbound traffic and all outbound traffic"

  tags = {

    Name = "${var.project_name}_full_access"
  }
}


resource "aws_vpc_security_group_ingress_rule" "allow_all_traffic_ipv4" {
 
  security_group_id = aws_security_group.full_access.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 

}

resource "aws_vpc_security_group_ingress_rule" "allow_all_traffic_ipv6" {

  security_group_id = aws_security_group.full_access.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" 

}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {

  security_group_id = aws_security_group.full_access.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {

  security_group_id = aws_security_group.full_access.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"

}

