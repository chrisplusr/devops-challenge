provider "aws" {
  region = "us-east-1"
}

variable "PRIV_KEY_PATH" {
  default = "apiki-key"
}

variable "PUB_KEY_PATH" {
  default = "apiki-key.pub"
}

resource "aws_key_pair" "desafio-key" {
  key_name   = "desafio-apiki"
  public_key = file(var.PUB_KEY_PATH)
}

resource "aws_instance" "desafio-apiki" {
  ami                    = "ami-04505e74c0741db8d"
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1c"
  key_name               = aws_key_pair.desafio-key.key_name
  vpc_security_group_ids = [aws_security_group.apiki_stack_sh.id]

  tags = {
    Name = "desafio-apiki-instance"
  }

  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "file" {
    source      = "docker-compose.yml"
    destination = "/tmp/docker-compose.yml"
  }

  provisioner "file" {
    source      = "desafio.conf"
    destination = "/tmp/desafio.conf"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }

  connection {
    user        = "ubuntu"
    private_key = file(var.PRIV_KEY_PATH)
    host        = self.public_ip
  }

  root_block_device {
    volume_size = 30
    tags = {
      FileSystem = "/root"
    }
  }
}