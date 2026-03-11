output "ec2_public_ip" {
        value =  aws_instance.terraformfirst.public_ip
}

output "ec2_public_ip" {
        value =  aws_instance.terraformfirst.public_dns
}

output "ec2_private_ip" {
        value =  aws_instance.terraformfirst.private_ip
}
