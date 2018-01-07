#!/bin/bash
echo "-------------------------------------------------------"
echo "=> Running Terraform Destroy"
echo "-------------------------------------------------------"

terraform destroy \
  -var 'aws_region=ap-northeast-2' \
  -var 'ssh_public_key_path=tmp/tde-ssh-key.pub' \
  -var 'ssh_private_key_path=tmp/tde-ssh-key' \
  tf
