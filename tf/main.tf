provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_vpc" "terraform_node_example" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "terraform_node_example" {
  vpc_id                  = "${aws_vpc.terraform_node_example.id}"
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true

  tags {
    Name = "Terraform Node Example"
  }
}

resource "aws_internet_gateway" "terraform_node_example" {
  vpc_id = "${aws_vpc.terraform_node_example.id}"

  tags {
    Name = "Terraform Node Example"
  }
}

resource "aws_route_table" "terraform_node_example" {
  vpc_id = "${aws_vpc.terraform_node_example.id}"

  tags = {
    "Name" = "Terraform Node Example"
  }
}

resource "aws_route" "terraform_node_example" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = "${aws_route_table.terraform_node_example.id}"
  gateway_id             = "${aws_internet_gateway.terraform_node_example.id}"
}

resource "aws_main_route_table_association" "terraform_node_example" {
  vpc_id         = "${aws_vpc.terraform_node_example.id}"
  route_table_id = "${aws_route_table.terraform_node_example.id}"
}

resource "aws_key_pair" "terraform_node_example" {
  key_name   = "terraform_node_example"
  public_key = "${file(var.ssh_public_key_path)}"
}

resource "aws_security_group" "terraform_node_example" {
  name   = "terraform_node_example"
  vpc_id = "${aws_vpc.terraform_node_example.id}"

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "8080"
    to_port     = "8080"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "terraform_node_example" {
  ami           = "${data.aws_ami.sample_app.id}"
  instance_type = "t2.micro"

  subnet_id              = "${aws_subnet.terraform_node_example.id}"
  vpc_security_group_ids = ["${aws_security_group.terraform_node_example.id}"]

  key_name = "${aws_key_pair.terraform_node_example.key_name}"

  associate_public_ip_address = true

  tags {
    Name = "terraform_node_example"
  }
}
