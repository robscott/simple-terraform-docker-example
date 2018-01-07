#!/bin/bash
echo "-------------------------------------------------------"
echo "=> Checking for Dependencies"
echo "-------------------------------------------------------"
if command -v aws >/dev/null 2>&1 ; then
  echo "AWS Installed:"
  echo $(aws --version)
else
  echo "AWS CLI tools not installed"
fi

if command -v terraform >/dev/null 2>&1 ; then
  echo "Terraform Installed:"
  echo $(terraform --version)
  echo ""
else
  echo "Terraform not installed"
fi

echo "-------------------------------------------------------"
echo "=> Checking for Valid AWS Credentials"
echo "-------------------------------------------------------"
aws sts get-caller-identity
echo ""

echo "-------------------------------------------------------"
echo "=> Creating an SSH key for this deployment"
echo "-------------------------------------------------------"
mkdir -p tmp
ssh-keygen -b 2048 -t rsa -f tmp/tde-ssh-key -q -N ""
echo ""

echo "-------------------------------------------------------"
echo "=> Running Terraform init"
echo "-------------------------------------------------------"
terraform init tf
echo ""

echo "-------------------------------------------------------"
echo "=> Running Terraform apply"
echo "-------------------------------------------------------"
terraform apply \
  -var 'aws_region=ap-northeast-2' \
  -var 'ssh_public_key_path=tmp/tde-ssh-key.pub' \
  -var 'ssh_private_key_path=tmp/tde-ssh-key' \
  tf
