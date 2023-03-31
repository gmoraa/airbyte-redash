# airbyte-redash
Datapipeline with Airbyte and Redash setup via infrastructure as code with Terraform.

## Variables
In order to execute this Terraform template you need to provide the AWS region and the CIDR for the VPC.

## Usage

1. ```cd terraform/datapipeline```
2. ```terraform init```
3. ```terraform plan```
4. ```terraform apply```

## Important Notes
If you are unable to access the web application, check the security groups which by default will allow only the internal traffic.