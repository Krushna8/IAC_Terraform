resource "aws_key_pair" "dove-key" {
  key_name   = "dovekey"
  public_key = file("testkey.pub")
}

resource "aws_instance" "dove-inst" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1
  key_name               = "dovekey"
  vpc_security_group_ids = ["sg-061c819b13d517741"]
  tags = {
    Name    = "Dove-Instance"
    Project = "Dove"
  }

  provisioner "remote-exec" {

    inline = [
      "sudo yum install wget unzip httpd -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo wget https://www.tooplate.com/zip-templates/2117_infinite_loop.zip",
      "sudo unzip -o 2117_infinite_loop.zip",
      "sudo cp -r 2117_infinite_loop/* /var/www/html/",
      "sudo systemctl restart httpd"
    ]
  }

  connection {
    user        = var.USER
    private_key = file("testkey")
    host        = self.public_ip
  }
}
output "PublicIP" {
  value = aws_instance.dove-inst.public_ip
}

output "PrivateIP" {
  value = aws_instance.dove-inst.private_ip
}