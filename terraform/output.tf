output "node_public_ip" {

value  = {for instance,attribute in aws_instance.node : instance => attribute["public_ip"] }

}
