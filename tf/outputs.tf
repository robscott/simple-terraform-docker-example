output "public_ip" {
  value = "${aws_instance.terraform_node_example.public_ip}"
}

output "full_server_address" {
  value = "http://${aws_instance.terraform_node_example.public_ip}:8080"
}
