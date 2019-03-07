
resource "aws_instance" "app_instance" {
  ami = "${var.app_ami_id}"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  subnet_id = "${aws_subnet.app_subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.app_group.id}"]
  user_data = "${data.template_file.app_init.rendered}"
  tags {
    Name = "${var.name}"
  }
}

resource "aws_subnet" "app_subnet" {
  vpc_id = "vpc-07e47e9d90d2076da"
  cidr_block = "172.31.4.0/24"
  availability_zone = "eu-west-1c"
  tags {
    Name = "anthony-app-subnet-tf"
  }
}

resource "aws_security_group" "app_group" {
  name        = "${var.name}"
  description = "security group for app"
  vpc_id = "vpc-07e47e9d90d2076da"
  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.name}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${data.aws_internet_gateway.default.id}"
  }

  tags = {
    Name = "${var.name}"
  }
}


resource "aws_route_table_association" "association" {
  subnet_id = "${aws_subnet.app_subnet.id}"
  route_table_id = "${aws_route_table.public.id}"
}

data "template_file" "app_init" {
  template = "${file("scripts/app/init.sh.tpl")}"
}
