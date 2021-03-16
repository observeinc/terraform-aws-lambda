# Lambda upload from S3 bucket

The configuration in this directory documents how to setup the Observe Lambda in a private VPC.

VPC setup mimics that found in official AWS [documentation](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Scenario2.html):

![diagram](nat-gateway-diagram.png?raw=true "VPC")

## Usage

To run this example, execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this will create AWS resources - once you are done, run `terraform destroy`.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.21 |
| aws | >= 2.68 |
| random | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.68 |
| random | >= 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| observe\_customer | Observe Customer ID | `string` | n/a | yes |
| observe\_domain | Observe Domain | `string` | `"observeinc.com"` | no |
| observe\_token | Observe token | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| lambda\_function | Lambda function |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
