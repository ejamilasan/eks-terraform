variable "cluster_name" {
    type = string
}

variable "cluster_version" {
    default = "1.27"
    type    = string
}

variable "region" {
    default = "us-west-2"
    type    = string
}

variable "vpc_id" {
    type = string
}

variable "iam_user_arn" {
    type = string
}

variable "node_group_instance_types" {
    default = ["t2.micro"]
    type    = list
}

variable "node_group_key_pair" {
    type = string
}

variable "default_tags" {
    type    = map(string)
    default = {
        managed_by_terraform = "true"
    }
}

variable "ip_to_whitelist" {
    type = string
}