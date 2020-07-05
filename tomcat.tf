data "template_file" "tomcatserver_data" {
  template = "${file("template/tomcat.tpl")}"
}

resource "aws_instance" "tomcat_server" {
  ami                         = var.ami
  key_name                    = var.key_name
  instance_type               = var.instance_type
  user_data                   = data.template_file.tomcatserver_data.rendered
  subnet_id                   = aws_subnet.subnet-3.id
  vpc_security_group_ids      = [aws_security_group.tomcat_server-sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "tomcat_server"
  }
}

resource "aws_security_group" "tomcat_server-sg" {
  name   = "tomcat_server-security-group"
  vpc_id = aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 8080
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
