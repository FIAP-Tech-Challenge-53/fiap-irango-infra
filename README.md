# Fiap iRango Infra
![terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![aws](https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)

## Architecture Diagram:
![Architecture diagram](./docs/fiap-irango-infra.png)

## Dependencies
- [Terraform](https://developer.hashicorp.com/terraform/install?product_intent=terraform)
- Make
  - [Windows](https://gnuwin32.sourceforge.net/packages/make.htm)
  - Linux:
  ```bash
  sudo apt update
  sudo apt install make
  ```

## Instructions to run
Before all, you need set AWS credentials ENVs using:
```bash
export AWS_ACCESS_KEY_ID=xxxxxx
export AWS_SECRET_ACCESS_KEY=xxxxxx
export AWS_REGION=us-east-1
```
Or configure it in windows environments.


### Create a S3 bucket to store terraform state
```bash
aws s3api create-bucket --bucket fiap-irango-tfstate --region us-east-1
```


### Create secrets in AWS Secrets Manager
```bash
cp secrets.json.example secrets.json
# Edit secrets.json with your secrets

aws secretsmanager create-secret --name fiap-irango-secrets-api --secret-string file://env.json
```


### To delete secrets
```bash
aws secretsmanager delete-secret --secret-id fiap-irango-secrets-api --force-delete-without-recovery
```


### Running terraform

#### Using make
```bash
# To init terraform
make init

# To run terraform plan
make plan

# To apply changes
make up
```

To destroy resources:
```bash
make down
```

#### Without make
```bash
# To init terraform
terraform -chdir=terraform init

# To run terraform plan
terraform -chdir=terraform plan

# To apply changes
terraform -chdir=terraform apply -auto-approve
```

To destroy resources:
```bash
terraform -chdir=terraform destroy -auto-approve
```
