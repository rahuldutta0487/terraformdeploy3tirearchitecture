# AWS 3-Tier Architecture with Terraform

This Terraform configuration creates a 3-tier AWS architecture matching the attached design:

- VPC with 2 Availability Zones
- 2 public subnets for the web tier and ALB
- 2 private app subnets for the application tier
- 2 isolated private DB subnets for the database tier
- Internet Gateway and NAT Gateway
- Application Load Balancer in public subnets
- Web tier Auto Scaling Group behind the ALB
- App tier Auto Scaling Group in private subnets
- RDS MySQL instance in private subnets

## Files

- `provider.tf` - AWS provider configuration
- `variables.tf` - input variables for region, subnet CIDRs, instance types, scaling sizes, and DB credentials
- `main.tf` - full architecture resources
- `outputs.tf` - exposed outputs for ALB DNS, ASG names, DB endpoint, and VPC
- `terraform.tfvars.example` - sample variable values

## Usage

1. Copy `terraform.tfvars.example` to `terraform.tfvars`
2. Replace `key_name` (use a valid EC2 Key Pair name or leave it blank if you do not need SSH), `db_password`, and any placeholder network values with your own values
3. Run:

```bash
terraform init
terraform plan
terraform apply
```

4. After provisioning, the ALB DNS name is available in `alb_dns_name`.

## Terraform variables

All environment and module configuration is now stored in `terraform.tfvars` using nested objects for each module:

- `project`
- `network`
- `web_asg`
- `app_asg`
- `db`

This keeps the root module clean while preserving one central configuration file.

## AWS credentials

Terraform needs AWS credentials to plan and apply. You have several safe options:

- Configure the AWS CLI profile and reference it in `terraform.tfvars`:

```bash
aws configure --profile myprofile
# then set aws_profile = "myprofile" in terraform.tfvars
```

- Use environment variables (temporary session):

```powershell
setx AWS_ACCESS_KEY_ID "your_key"
setx AWS_SECRET_ACCESS_KEY "your_secret"
setx AWS_DEFAULT_REGION "us-east-1"
```

- Use a shared credentials file (default is `~/.aws/credentials`) and reference path via `aws_shared_credentials_file` variable.

If you don't provide credentials, `terraform plan` will fail with "No valid credential sources found" (this workspace's current error). Do not commit long-lived credentials to the repository.

## Notes

- The web tier is publicly reachable through the ALB.
- The app tier is isolated in private subnets and only receives traffic from the web tier.
- The database tier is isolated in private subnets and only receives traffic from the app tier.
