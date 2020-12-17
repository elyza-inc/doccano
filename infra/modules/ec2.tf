
resource "aws_instance" "doccano" {
  instance_type = "t2.large"
  ami           = var.doccano_ami_image_id

  vpc_security_group_ids = [var.security_group_ssh, var.security_group_public]
  subnet_id              = var.subnet_id
  key_name               = aws_key_pair.doccano.id

  user_data = <<EOF
  #!/bin/bash
  cd /home/ec2-user/doccano_mhm
  export PASSWORD=k4MnXCQp
  export PUBLIC_HOST=${var.host}
  docker-compose up -d
  EOF

  tags = {
    Name = "aws-instance-mhm-doccano"
  }
}

resource "aws_key_pair" "doccano" {
  key_name   = "doccano-keypair-mhm-dd"
  public_key = file("../key/doccano-key-mhm-dd.pub")
}
