# Deploy Helloworld

This is a Hello World project 

## Resources
The following terraform code deploys a Helloworld flask application to an EKS cluster in AWS VPC

#### Resources to be deployed
- AWS VPC
- Two Public and Two Private Subnets in different availability zones (us-east1a/b)
- Internet Gateway to provide internet access for services within the VPC
- NAT Gateway for public subnets
- Routing Tables and associate subnets with them
- Security Groups with associated subnets and Security Group rules
- EKS Cluster with IAM Roles and Policies
- EKS Node Group for application workload with IAM Roles and Policies
- Helm chart to install Helloworld Flask Application


## Running this project

#### Prerequisites
1. Create an AWS account, if you don't have one.

2. Install Terraform on you machine - https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli 

3. Install AWS CLI - https://docs.aws.amazon.com/cli/v1/userguide/install-macos.html#install-macosos-bundled-sudo 

4. Create Terraform IAM User with Access Key and Secret Key - https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html

### Create s3 bucket for terraform backend
In AWS management console, create an S3 bucket with folder structure `terraform/state`. See terraform backend code below:
```
terraform {
  backend "s3" {
    bucket         = "<REDACTED>"
    key            = "terraform/state/tfstate"
    region         = "<REDACTED>"
  }
}
```


### Running Terraform
From the project root, change directory into the terraform workspace
```
cd terraform-env/dev
```

#### Export IAM user credentials
Export AWS terraform IAM user credentials to CLI before running terraform:
```
export AWS_ACCESS_KEY_ID="<TERRAFORM_AWS_ACCESS_KEY_ID>"
export AWS_SECRET_ACCESS_KEY="<TERRAFORM_AWS_SECRET_ACCESS_KEY>"
```

#### Deploy resources

```
$ terraform init
$ terraform plan
$ terraform apply
```

### View the python app
Login to AWS CLI on your terminal
```
$ aws configure
```

Run the following commands:
```
$ aws eks update-kubeconfig --region us-east-1 --name helloworld-dev-cluster

$ export SERVICE_IP=$(kubectl get svc --namespace default helloworld-flask-app-service --template "{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}")

$ echo http://$SERVICE_IP:80  
```

Copy the url and patse in browser
