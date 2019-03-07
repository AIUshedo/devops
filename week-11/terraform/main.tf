provider "aws" {
  region = "eu-west-1"
}
resource "aws_instance" "db_instance" {
  ami = "${var.db_ami_id}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.db_subnet.id}"
  tags {
  Name = "${var.db_name}"
  }
}

data "aws_internet_gateway" "default" {
  filter {
    name = "attachment.vpc-id"
    values = ["${var.vpc_id}"]
  }
}

module "app"{
  source = "modules/app_tier"
  vpc_id = "${var.vpc_id}"
  name = "${var.name}"
  app_ami_id = "${var.app_ami_id}"
}
