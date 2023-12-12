module "eks" {
    source  = "terraform-aws-modules/eks/aws"
    version = "~> 19.0"

    tags = var.default_tags

    vpc_id                   = var.vpc_id
    subnet_ids               = data.aws_subnets.default_vpc_subnets.ids
    control_plane_subnet_ids = data.aws_subnets.default_vpc_subnets.ids

    cluster_name                   = var.cluster_name
    cluster_version                = var.cluster_version
    cluster_endpoint_public_access = true

    create_iam_role = false
    iam_role_arn    = data.aws_iam_role.eks_cluster_role.arn

    kms_key_enable_default_policy = true

    manage_aws_auth_configmap = true
    aws_auth_users = [
        {
            userarn  = var.iam_user_arn
            username = "admin"
            groups   = ["system:masters"]
        },
    ]

    cluster_addons = {
        coredns = {
            addon_version = "v1.10.1-eksbuild.4"
            most_recent   = false
        }
        kube-proxy = {
            addon_version = "v1.27.6-eksbuild.2"
            most_recent   = true
        }
        vpc-cni = {
            addon_version = "v1.15.0-eksbuild.2"
            most_recent   = false
        }
        aws-ebs-csi-driver = {
            addon_version = "v1.23.0-eksbuild.1"
            most_recent   = false
        }
    }

    cluster_security_group_additional_rules = {
        https_rule = {
            type                  = "ingress"
            from_port             = 443
            to_port               = 443
            protocol              = "tcp"
            cidr_blocks           = [data.aws_vpc.default_vpc.cidr_block, var.ip_to_whitelist]
            source_security_group = true
        }
    }

    eks_managed_node_group_defaults = {
        create_iam_role = false
        iam_role_arn    = data.aws_iam_role.node_group_role.arn
    }

    eks_managed_node_groups = {
        devops-eks-node = {
            min_size     = 1
            max_size     = 2
            desired_size = 2

            instance_types = var.node_group_instance_types
            key_name       = var.node_group_key_pair
            capacity_type  = "ON_DEMAND"

        }
    }

    node_security_group_additional_rules = {
        https_rule = {
            type                  = "ingress"
            from_port             = 443
            to_port               = 443
            protocol              = "tcp"
            cidr_blocks           = [data.aws_vpc.default_vpc.cidr_block, var.ip_to_whitelist]
            source_security_group = true
        },
        http_rule = {
            type                  = "ingress"
            from_port             = 80
            to_port               = 80
            protocol              = "tcp"
            cidr_blocks           = [data.aws_vpc.default_vpc.cidr_block, var.ip_to_whitelist]
            source_security_group = true
        },
        ssh_rule = {
            type                  = "ingress"
            from_port             = 22
            to_port               = 22
            protocol              = "tcp"
            cidr_blocks           = [data.aws_vpc.default_vpc.cidr_block, var.ip_to_whitelist]
            source_security_group = true
        }
    }
}