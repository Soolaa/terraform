resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cider_block

  tags = {
    Name       = "${var.env_prefix}-vpc"
    Created_by = "terraform"
  }
}

resource "aws_subnet" "myapp-subnet" {
  vpc_id     = aws_vpc.myapp-vpc.id
  cidr_block = var.subnet_cider_block
  tags = {
    Name       = "${var.env_prefix}-subnet-1"
    Created_by = "terraform"
  }
}

# resource "aws_route_table" "myapp-route" {
#   vpc_id = aws_vpc.myapp-vpc.id
#   route {
#     cidr_block = "0.0.0.0/24"
#     gateway_id = aws_internet_gateway.myapp-igw.id
#   }
#   tags = {
#     Name       = "${var.env_prefix}-route-1"
#     Created_by = "terraform"
#   }
# }

# resource "aws_route_table_association" "my-app-association" {
#   subnet_id = aws_subnet.myapp-subnet.id
#   route_table_id = aws_route_table.myapp-route.id
# }

resource "aws_internet_gateway" "myapp-igw" {
  vpc_id = aws_vpc.myapp-vpc.id
  tags = {
    Name       = "${var.env_prefix}-igw-1"
    Created_by = "terraform"
  }
}

resource "aws_default_route_table" "main-rbt" {
  default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myapp-igw.id
  }
  tags = {
    Name = "${var.env_prefix}-main-rbt"
  }
}

resource "aws_default_security_group" "default-sq" {
  vpc_id = aws_vpc.myapp-vpc.id
  tags = {
    Name = "${var.env_prefix}-def-sq"
  }

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = var.my-ip
  }
  ingress {
    protocol    = "tcp"
    from_port   = 8080
    to_port     = 8080
    cidr_blocks = var.my-ip
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = var.my-ip
  }
}

data "aws_ami" "latest_aws_ami_id" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["al2023-ami-2023.4.*-kernel-6.1-x86_64"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}
 output "latest-ami-id" {
  value = data.aws_ami.latest_aws_ami_id.id   
 }
 resource "aws_instance" "myapp-ec2" {
   ami = data.aws_ami.latest_aws_ami_id.id
   instance_type = var.instance_type
 }
  
#   subnet_id = aws_subnet.myapp-subnet.id
#   vpc_security_group_ids = [aws_default_security_group.default-sq.id]
#   #availability_zone = var.availability_zone
#   associate_public_ip_address = true
 
# }

# data "aws_vpc" "sahar-data-vpc" {
#   default = true
# }

# resource "aws_subnet" "data-sahar-subnet" {
#   vpc_id            = data.aws_vpc.sahar-data-vpc.id
#   cidr_block        = "172.31.128.0/20"
#   availability_zone = "us-east-1a"

#   tags = {
#     Name = "sahar-def-subnet"
#   }

# }

# resource "aws_instance" "sahar-ec2" {
#   ami                         = var.ami_id
#   instance_type               = var.instance_type
#   key_name                    = var.key_name
#   associate_public_ip_address = true

#   tags = {
#     Name = "sahar-ec2"
#   }
# }

# output "vpc-id" {
#   value = aws_vpc.sahar-vpc1.id
# }

# output "ec2-public-ip" {
#   value = aws_instance.sahar-ec2.public_ip
# }

# output "ec2-dns-name" {
#   value = aws_instance.sahar-ec2.public_dns

# }
# resource "aws_s3_bucket" "sahar-s3" {
#   bucket = "sahar-state-file"

#   tags = {
#     Name = "sahar-state-bucket"
#   }
# }