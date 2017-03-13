# README #

Terraform scripts to create an AWS VPC.

The TF plan will create the following resources:

* x1 vpc
* x1 Public route table
* x1 Internet gateway
* x2 Public subnets
* x2 Private subnets

### Prerequisites ###

* AWS account - https://aws.amazon.com
* AWS IAM user account with AWS access/secret keys and permission to create specified resources
* Terraform installed - https://www.terraform.io
* Git account and git installed - https://github.com

### How do I get set up? ###

* Clone the repo
* Create terraform.tfvars
* Run terraform plan
* Run terraform apply
* Run terraform destroy

### Who do I talk to? ###

* Richard Bosomworth
