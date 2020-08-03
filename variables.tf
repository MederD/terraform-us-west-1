variable "vpc_cidr_block" {
    type = string
    default = "10.0.0.0/16"
    description = "The CIDR block for the VPC."
}

variable "sub_cidr_block" {
    type = list(string)
    default = ["10.0.0.0/24",
               "10.0.1.0/24"]
    description = "The CIDR block for the subnets."
}

variable "az" {
	type = list(string)
	default = ["us-west-1a", "us-west-1b"]
    description = "Availibility zones for the subnets."
}

variable "region" {
    default = "us-west-1"
    description = "Region provisioning"
}

variable "ami_name" {
    default = "ami-05655c267c89566dd"
    type    = string
    description = "This will be defining your ami"
}  
  
variable "instance_type" {
    default = "t2.micro"
    type    = string
    description = "This will be instance type"
}

variable "key_name" {}

variable "user_name" {}

