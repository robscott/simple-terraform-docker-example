provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_key_pair" "terraform_node_example" {
  key_name = "terraform_node_example"
  public_key = "${file(var.ssh_public_key_path)}"
}

resource "aws_security_group" "terraform_node_example" {
  name = "terraform_node_example"

  ingress {
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "8080"
    to_port = "8080"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = "80"
    to_port = "80"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = "443"
    to_port = "443"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "terraform_node_example" {
  ami = "${data.aws_ami.coreos.id}"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.terraform_node_example.id}"]

  key_name = "${aws_key_pair.terraform_node_example.key_name}"

  connection {
    user = "core"
    agent = true
    private_key = "${file(var.ssh_private_key_path)}"
  }

  provisioner "remote-exec" {
    inline = [
      "/usr/bin/docker run -p 8080:8080 -e PORT=8080 -d --cap-drop ALL --read-only quay.io/robertjscott/sample-app-server:0.1.0",
    ]
  }

  tags {
    Name = "terraform_node_example"
  }
}
