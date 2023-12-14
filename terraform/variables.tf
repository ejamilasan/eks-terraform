variable "cluster_name" {
  default = "sampleCluster"
  type    = string
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
  default = "vpc-123456789"
  type    = string
}

variable "iam_user_arn" {
  default = "arn:aws:iam::123456789:user/sample-user"
  type    = string
}

variable "node_group_instance_types" {
  default = ["t2.micro"]
  type    = list(any)
}

variable "node_group_key_pair" {
  default = "sample-key-pair"
  type    = string
}

variable "default_tags" {
  type = map(string)
  default = {
    managed_by_terraform = "true"
  }
}

variable "ip_to_whitelist" {
  default = "10.0.0.0/16"
  type    = string
}