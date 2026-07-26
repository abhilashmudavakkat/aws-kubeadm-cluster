# Ansible

This directory contains the Ansible automation used to configure a Kubernetes cluster on AWS after the infrastructure has been provisioned using Terraform.

## Components

### `kubeadm_cluster.yml`

The main playbook responsible for orchestrating the Kubernetes cluster deployment. It performs the following tasks:

- Describes the provisioned EC2 instances using AWS tags.
- Creates a dynamic in-memory Ansible inventory.
- Executes the `common`, `master`, and `worker` roles.
- Displays the public IP addresses of the Kubernetes cluster nodes.


## Playbook Variables

The following variables are defined in `variables.yaml` and are consumed by the main playbook.

| Variable | Description |
|----------|-------------|
| `aws_region` | AWS region containing the provisioned EC2 instances. |
| `project_name` | Value of the **Project** tag used to discover the provisioned EC2 instances. |
| `project_environment` | Value of the **Environment** tag used to discover the provisioned EC2 instances. |
| `instance_names` | Value of the **Name** tag used to discover the provisioned EC2 instances. |
| `python_modules` | Python modules required on the Ansible control node. |
| `packages` | System packages required on the Ansible control node. |
| `node_user` | SSH user used to connect to the Kubernetes nodes.


### `roles/common`

Performs common configuration on all cluster nodes by:

- Loading and persisting the required kernel modules.
- Applying the required `sysctl` kernel parameters for Kubernetes networking.
- Installing and configuring the containerd container runtime.
- Installing Kubernetes dependency packages.
- Configuring the Kubernetes package repository.


#### Configurable Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `k8s_version` | `v1.30` | Kubernetes version to install on all cluster nodes. |

---

### `roles/master`

Configures the Kubernetes control plane by:

- Installing `kubeadm`, `kubelet`, and `kubectl`.
- Initializing the Kubernetes control plane.
- Configuring `kubectl` for the node user.
- Deploying the Flannel CNI plugin.
- Generating the worker node join command.

#### Configurable Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `pod_network_cidr` | `192.20.0.0/16` | Pod network CIDR for the Kubernetes cluster. |

---

### `roles/worker`

Configures Kubernetes worker nodes by:

- Installing `kubeadm` and `kubelet`.
- Joining worker nodes to the Kubernetes cluster.

This role does not expose any configurable variables.

