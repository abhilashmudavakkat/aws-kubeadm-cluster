# AWS Kubeadm Cluster

Automated provisioning of a Kubernetes cluster on AWS using Terraform and Ansible.

## Overview

This project provisions a Kubernetes cluster on AWS using Infrastructure as Code (Terraform) and Configuration Management (Ansible).

The automation performs the following tasks:

- Provisions **1 Control Plane (Master)** EC2 instance
- Provisions **2 Worker** EC2 instances
- Configures networking and security groups
- Installs Containerd as the container runtime
- Installs Kubernetes components (kubeadm, kubelet, kubectl)
- Initializes the Kubernetes control plane
- Deploys Flannel as the CNI plugin
- Joins worker nodes to the cluster



## Technologies

- AWS EC2
- Terraform
- Ansible
- Kubernetes (kubeadm)
- Containerd
- Flannel CNI

## Project Structure

```text
aws-kubeadm-cluster/
├── README.md
├── ansible
│   ├── ansible.cfg
│   ├── key
│   ├── kubeadm_cluster.yml
│   ├── roles
│   │   ├── common
│   │   │   ├── README.md
│   │   │   ├── defaults
│   │   │   │   └── main.yml
│   │   │   ├── files
│   │   │   ├── handlers
│   │   │   │   └── main.yml
│   │   │   ├── meta
│   │   │   │   └── main.yml
│   │   │   ├── tasks
│   │   │   │   └── main.yml
│   │   │   ├── templates
│   │   │   │   └── config.toml.tmpl
│   │   │   ├── tests
│   │   │   │   ├── inventory
│   │   │   │   └── test.yml
│   │   │   └── vars
│   │   │       └── main.yaml
│   │   ├── master
│   │   │   ├── README.md
│   │   │   ├── defaults
│   │   │   │   └── main.yml
│   │   │   ├── files
│   │   │   ├── handlers
│   │   │   │   └── main.yml
│   │   │   ├── meta
│   │   │   │   └── main.yml
│   │   │   ├── tasks
│   │   │   │   └── main.yml
│   │   │   ├── templates
│   │   │   │   └── kube-flannel.yml.tmpl
│   │   │   ├── tests
│   │   │   │   ├── inventory
│   │   │   │   └── test.yml
│   │   │   └── vars
│   │   │       └── main.yml
│   │   └── worker
│   │       ├── README.md
│   │       ├── defaults
│   │       │   └── main.yml
│   │       ├── files
│   │       ├── handlers
│   │       │   └── main.yml
│   │       ├── meta
│   │       │   └── main.yml
│   │       ├── tasks
│   │       │   └── main.yml
│   │       ├── templates
│   │       ├── tests
│   │       │   ├── inventory
│   │       │   └── test.yml
│   │       └── vars
│   │           └── main.yml
│   └── variables.yaml
└── terraform
    ├── data_sources.tf
    ├── key
    ├── key.pub
    ├── main.tf
    ├── output.tf
    ├── provider.tf
    ├── terraform.tfstate
    ├── terraform.tfstate.backup
    ├── terraform.tfvars
    ├── userdata.sh
    └── variables.tf```

## Prerequisites

- AWS Account
- Terraform
- Ansible
- SSH Key Pair

## Deployment

### Provision AWS Infrastructure

```bash
cd terraform/
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

### Configure Kubernetes Cluster

```bash
cd ansible/
ansible-playbook kubeadm_cluster.yml
```


## Features

- Infrastructure provisioning with Terraform
- Configuration management with Ansible
- Automated Kubernetes cluster setup using kubeadm
- 1 Control Plane and 2 Worker EC2 instances
- Flannel CNI deployment
- Automatic worker node join
- Ansible roles


## Verification

```bash
kubectl get nodes
```

Expected output:

```text
NAME          STATUS   ROLES           AGE
k8s-master    Ready    control-plane   ...
k8s-worker1   Ready    <none>          ...
k8s-worker2   Ready    <none>          ...
```

## Cleanup

```bash
cd terraform/
terraform destroy
```
