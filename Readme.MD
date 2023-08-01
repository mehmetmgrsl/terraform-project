## Install Terraform to Ubuntu

- https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli 

## Enable tab completion

- touch ~/.bashrc
- terraform -install-autocomplete

## Commands
- terraform fmt
- terraform init
- terraform plan
- sudo terraform apply
- sudo -i
- cat pets.txt
- terraform show
- sudo terraform apply --auto-approve


- terraform show
- terraform validate
- sudo apt install graphviz -y
- terraform graph | dot -Tsvg > graph.svg

- terraform init -upgrade

- terraform state mv aws_dynamodb_table.cars aws_dynamodb_table.vehicles
- terraform state pull
- terraform state rm ADDRESS

- after creating the ec2-instance -> ssh -i web-nginx ubuntu@public-ip-address

- terraform taint [options] address

//  informs Terraform that a particular object has become degraded or damaged. Terraform represents this by marking the object as "tainted" in the Terraform state, and Terraform will propose to replace it in the next plan you create

- terraform untaint [options] address

// If Terraform currently considers a particular object as tainted but you've determined that it's actually functioning correctly and need not be replaced, you can use terraform untaint to remove the taint marker from that object.

- Terraform Log Levels
   - INFO, WARNING, ERROR, DEBUG, TRACE
   - export TF_LOG=TRACE
   - export TF_LOG_PATH=/tmp/terraform.log


### Resources:

1. Terraform Installation - https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli 
2. Terraform Basics Training Course - https://kodekloud.com/courses/terraform-for-beginners/