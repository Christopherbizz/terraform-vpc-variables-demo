# AWS VPC with EC2 Instance (Terraform)

Terraform configuration that provisions a custom VPC with public networking and a single EC2 instance, using variables and outputs for reusability.

## Architecture

- Custom VPC (`10.10.0.0/16` by default)
- Public subnet with an Internet Gateway and route table association
- Security group allowing SSH (restricted to a defined CIDR — see Configuration) and unrestricted egress
- Single EC2 instance deployed into the subnet with a public IP
- Outputs for the instance's public and private IP addresses

## Usage

```bash
terraform init
terraform plan
terraform apply
```

Requires AWS credentials configured via the AWS CLI or environment variables. No credentials are hardcoded in this repo.

## Configuration

All values are defined as variables with defaults in `variable.tf`:

| Variable | Description | Default |
|---|---|---|
| `region` | AWS region | `us-east-1` |
| `instance-type` | EC2 instance type | `t2.micro` |
| `ami` | AMI ID | `ami-04ff98ccbfa41c9ad` |
| `key` | EC2 key pair name | `rtp-03` |
| `vpc-cidr` | VPC CIDR block | `10.10.0.0/16` |
| `subnet1-cidr` | Subnet CIDR block | `10.10.1.0/24` |
| `az1` | Availability zone | `us-east-1d` |

Override defaults with a `terraform.tfvars` file or `-var` flags rather than editing the source — in particular, set your own `key` (EC2 key pair must already exist in your account) and a scoped `allowed_ssh_cidr` before applying.

## Outputs

- `public_ip_of_demo_server` — the instance's public IP
- `private_ip_of_demo_server` — the instance's private IP

## Security notes

State is intentionally excluded from version control (see `.gitignore`). For production use, this should be extended with a remote encrypted backend, least-privilege IAM scoping for the instance role, and SSH access restricted to a known CIDR rather than left open.
