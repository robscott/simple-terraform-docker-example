variable "aws_region" {
  description = "AWS Region to deploy infrastructure in"
  default = "us-east-2"
}

variable "ssh_public_key_path" {
  description = "SSH public key used to connect to server"
  default = "~/.ssh/id_rsa.pub"
}

variable "ssh_private_key_path" {
  description = "SSH private key used to connect to server"
  default = "~/.ssh/id_rsa"
}
