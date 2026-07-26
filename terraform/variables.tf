variable "aws_region" {

  type        = string
  description = "Desired AWS Region"
}


variable "project_name" {

  type        = string
  description = "Project Name"
}


variable "project_environment" {

  type        = string
  description = "Project Environment"
}


variable "instance_type" {

  type        = string
  description = "Desired Instance Type"
}


variable "instance_hostnames" {

  type        = map(string)
  description = "Map of Instance Names mapped to Desired HostNames"
}


variable "instance_ami" {

  type        = string
  description = "Desired Instance AMI"

}


variable "root_volume_size" {

  type        = number
  description = "Root EBS Volume Size Required"

}

variable "security_group_id" {

  type        = string
  description = "Desired Security Group"
}
