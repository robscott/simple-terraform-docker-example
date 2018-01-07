# Packer Built AMI for this app
data "aws_ami" "sample_app" {
  most_recent = true
  owners      = ["098755368174"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["robertjscott.ca/sample-app-*"]
  }
}
