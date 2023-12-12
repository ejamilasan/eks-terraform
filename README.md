# eks-terraform

## pre-reqs
    1. Access to AWS
    2. Create an ec2 keypair in AWS

## terraform
    1. You must be authenticated to you AWS account (cli).
    2. Create `./terraform/variables.tfvars` with the following params:
        ```
        cluster_name = "sample-cluster" 
        cluster_version = "1.27"
        region = "us-west-2"
        vpc_id = "vpc-12345"
        iam_user_arn = "arn..."
        node_group_instance_types = ["t2.micro"]
        node_group_key_pair = "sample-key-pair"
        ip_to_whitelist = "x.x.x.x/32"
        ```
    3. Go to the `./terraform` directory then run:
        ```
        terraform init
        terraform apply -var-file=variables.tfvars
        ```