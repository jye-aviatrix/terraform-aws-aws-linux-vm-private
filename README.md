# terraform-aws-aws-linux-vm-private

The purpose of this module is to spin up a test server in private subnet quickly.

1. Create Ubuntu Test VM in Private Subnet
2. Allow incoming SSH from anywhere
3. Allow ping from anywhere
4. Require providers block in root module
```
terraform {
  required_providers {
     aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

```

## Example

```terraform
module "aws-linux-vm-private" {
  source  = "jye-aviatrix/aws-linux-vm-private/aws"
  version = "1.0.5"
  key_name  = "key-pair"
  vm_name   = "private1"
  vpc_id    = "vpc-04fc"
  subnet_id = "subnet-0ead"
}

output "private1" {
  value = module.aws-linux-vm-private
}
```