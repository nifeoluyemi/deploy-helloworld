# Graylog Helloworld

This is a Hello World project 


## Running this project

#### Prerequisites
1. Create an AWS account, if you don't have one.

2. Install Terraform on you machine - https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli 

3. Install AWS CLI - https://docs.aws.amazon.com/cli/v1/userguide/install-macos.html#install-macosos-bundled-sudo 

4. Create Terraform IAM User with Access Key and Secret Key - https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html

### Running Terraform
From the project root, change directory into the terraform workspace
```
cd terraform-env/dev
```

#### Export IAM user credentials
Export AWS terraform IAM user credentials to cli
```
export AWS_ACCESS_KEY_ID="<TERRAFORM_AWS_ACCESS_KEY_ID>"
export AWS_SECRET_ACCESS_KEY="<TERRAFORM_AWS_SECRET_ACCESS_KEY>"
```

#### Deploy resources

```
terraform init
terraform plan
terraform apply
```
