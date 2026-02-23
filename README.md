# Lab M4.02 - Variables & Parameterization

**Course:** Cloud Engineering Bootcamp - Week 4  
**Module:** Infrastructure as Code with Terraform  
**Lab Type:** Individual  
**Estimated Time:** 45-60 minutes
**Completed:** February 23, 2026

---

## 📋 Overview

Make your Terraform configurations flexible and reusable using input variables, outputs, and environment-specific configurations.

## 🎯 Learning Objectives

- Define and use input variables
- Implement variable validation
- Create multi-environment setups
- Use .tfvars files
- Export meaningful outputs

## 🎯 Learning Objectives (Achieved)

- Use **input variables** to parameterize Terraform configurations
- Implement **variable validation** rules
- Create **multi-environment** setups (dev / prod)
- Use **.tfvars** files for environment-specific values
- Define and export **meaningful outputs**
- Apply **DRY** principles by avoiding code duplication






## Implementation Details

### 1. Variables & Validation

Defined in `variables.tf`:

```hcl
variable "environment" {
  type = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "bucket_prefix" {
  type = string
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.bucket_prefix))
    error_message = "Bucket prefix must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "enable_versioning" { type = bool, default = false }
variable "aws_region"        { type = string, default = "us-east-1" }
variable "tags"              { type = map(string), default = {} }
2. Environment-specific .tfvars files
dev.tfvars





2. Environment-specific .tfvars files
dev.tfvars
environment       = "dev"
bucket_prefix     = "mahmadiapp-bootcamp"
enable_versioning = false
aws_region        = "us-east-1"

tags = {
  Owner   = "DevTeam"
  Project = "CloudBootcamp"
  Cost    = "Development"
}



prod.tfvars

environment       = "prod"
bucket_prefix     = "mahmadiapp-bootcamp"
enable_versioning = true
aws_region        = "us-east-1"

tags = {
  Owner   = "PlatformTeam"
  Project = "CloudBootcamp"
  Cost    = "Production"
  Backup  = "Daily"
}

3. Multi-environment Deployment
Used Terraform workspaces to separate state:


# Development (default workspace)
terraform apply -var-file="dev.tfvars"

# Production
terraform workspace new prod
terraform workspace select prod
terraform apply -var-file="prod.tfvars"



Final deployed resources:





Environment| Bucket Name.                 | Versioning| Owner  |    Cost    | Backup|
dev        |mahmadiapp-bootcamp-dev-bucket| Disabled  | DevTeam| Development| —
prod       |mahmadiapp-bootcamp-prod-bucket|   Enabled. |PlatformTeam| production| Daily


4. Outputs
output "bucket_id"          { value = aws_s3_bucket.main.id }
output "bucket_arn"         { value = aws_s3_bucket.main.arn }
output "bucket_region"      { value = aws_s3_bucket.main.region }
output "versioning_enabled" { value = var.enable_versioning }




## 📁 Repository Structure

```
ce-lab-terraform-variables/
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
├── dev.tfvars
├── prod.tfvars
└── screenshots/
               ├── Terraform apply output – dev environment.png
               ├── Terraform apply output – prod environment.png
               ├── AWS S3 Console showing both buckets.png
               ├── Bucket Versioning: dev (Disabled)vsBucket Versioning: prod(Enabled).png





6. Cleanup (Optional – to avoid unnecessary costs)
# Destroy dev
terraform workspace select default
terraform destroy -var-file="dev.tfvars" -auto-approve

# Destroy prod
terraform workspace select prod
terraform destroy -var-file="prod.tfvars" -auto-approve



Lessons Learned

Variable validation prevents common configuration mistakes early.
Workspaces provide clean separation of environments without duplicating code.
Versioning and proper tagging make production environments more robust and traceable.
Public access blocking is a simple but critical security baseline.


Cloud Engineering Bootcamp – Week 4
Submitted by: Maryam Ahamdi


**Cloud Engineering Bootcamp** | Week 4 - Infrastructure as Code
