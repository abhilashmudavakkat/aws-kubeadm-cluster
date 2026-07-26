# Terraform

This directory contains the Terraform code used to provision the AWS infrastructure for the Kubernetes cluster.

## What it creates

* Creates an EC2 key pair for SSH access.
* Creates a security group with full inbound and outbound access in the default VPC.
* Creates three EC2 instances using the `for_each` meta-argument:

  * One master node
  * Two worker nodes

## Tags

Each EC2 instance is assigned the following tags:

- **Name** - Set from the instance name (the key in the instance-to-hostname map).
- **Role** - Set to `master` or `worker` based on the instance name.
- **Hostname** - Set from the corresponding hostname value in the instance-to-hostname map.

These tags are used later by the Ansible playbook to:

* Discover the provisioned EC2 instances.
* Create the `master` and `worker` inventory groups.
* Configure the hostname of each node.

## Outputs

After the infrastructure is provisioned, Terraform displays the public IP addresses of all EC2 instances.
