aws_region = "ap-south-1"

project_name = "kubeadm"

project_environment = "test"

instance_type = "t2.medium"

instance_hostnames = {

  "k8s-master"  = "k8s-master.node.internal"
  "k8s-worker1" = "k8s-worker1.node.internal"
  "k8s-worker2" = "k8s-worker2.node.internal"
}


instance_ami = "ami-01a00762f46d584a1"

root_volume_size = 20

security_group_id = "sg-004031891403c1ddc"
