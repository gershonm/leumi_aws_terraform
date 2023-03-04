resource "aws_eip" "test_ec2" {
  vpc = true
}

resource "aws_eip_association" "test_ec2" {
  instance_id   = aws_instance.test_ec2.id
  allocation_id = aws_eip.test_ec2.id
}

# aws_instance.test_ec2
resource "aws_instance" "test_ec2" {
  ami           = data.aws_ami.linux_2.image_id
  instance_type = var.instance_type

  key_name               = var.aws_key
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.test_ec2.id]

  root_block_device {
    volume_size           = 50
    volume_type           = "gp2"
    delete_on_termination = true
  }

  tags = {
    Name = var.EC2_name
  }

  user_data = "${path.module}/user_data.sh"

}

# Security Group

resource "aws_security_group" "test_ec2" {
  vpc_id      = aws_vpc.this.id
  name        = "GerM EC2 SG"
  description = "SG for GerM EC2"
  tags = {
    Name = format("%s %s", var.vpc_name, "SG")
  }

}

resource "aws_security_group_rule" "inbound_leumi_proxy" {
  type              = "ingress"
  description       = "allow only leumi proxy from all ports"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [var.leumi_proxy]
  security_group_id = aws_security_group.test_ec2.id
}

resource "aws_security_group_rule" "outbound_leumi_proxy" {
  type              = "egress"
  description       = "allow only leumi proxy from all ports"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [var.leumi_proxy]
  security_group_id = aws_security_group.test_ec2.id
}