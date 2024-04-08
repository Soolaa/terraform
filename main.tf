
# resource "aws_key_pair" "sahar" {
#   key_name   = "sahar-key"
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDUB1szmKcfJGun7rPNvp6IHkD9bJEhPR7ZBujaZnOADWVaGUIKJ5k1/w2OOqpV3tEnEOcSF3kKHz2AtUj2t+E9ABaERylyadnkNXwfjTvFaO97uLElZG2h1R79Z8SQELxn94A0awMVhSdAHoDxDUR94yNxqwZdXG18QnEvviwPFD3ixh31cBtiz+5vo3B2qXzKAJ/iK/VECXloOf3bg5ZN0gY8lPvy9U14shd80OKtlc3BjBDxBYuFJihBeh0LDE6FbVr7izTyO8m0Hru8af+cPbiK6jmif4hMXyzv5v98PigkBPSUICPec30b0E7DZF8YQOR4fWyJRK5ZWEfp+yipNYKRe3AOrgZQFQDx3WAFZzBBS5ovkIPLoP39lW4X5PTeh5SITrIvMdzLrrTmQIK5JNXiqzTldwbNEi/VKTBlZmGSdi/+CghdtZnj7zhw5n7WqwMhwmKR5rvsE7rsXW8c+W/obryBth8YT52D7PcGXQuKd9ib+4uACrIEZ3TFgns= surfacebook@DESKTOP-CBA4DCT"
# }

# resource "aws_instance" "web" {
#   ami           = "ami-07d9b9ddc6cd8dd30"
#   instance_type = "t2.micro"
#   key_name      = aws_key_pair.sahar.key_name

#   tags = {
#     Name = "sahar-terrarom"
#   }
# }
resource "aws_vpc" "sahar-vpc1" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "sahar-vpc1"
  }
}

resource "aws_subnet" "sahar-vpc1-subnet" {
  vpc_id     = aws_vpc.sahar-vpc1.id
  cidr_block = var.cider_blocks[1].cider_block
  tags = {
    Name : var.cider_blocks[1].name
  }
}

data "aws_vpc" "sahar-data-vpc" {
  default = true
}

resource "aws_subnet" "data-sahar-subnet" {
  vpc_id            = data.aws_vpc.sahar-data-vpc.id
  cidr_block        = "172.31.128.0/20"
  availability_zone = "us-east-1a"

  tags = {
    Name = "sahar-def-subnet"
  }

}

resource "aws_instance" "sahar-ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = {
    Name = "sahar-ec2"
  }
}

output "vpc-id" {
    value = aws_vpc.sahar-vpc1.id
}

output "ec2-public-ip" {
  value =  aws_instance.sahar-ec2.public_ip
}

output "ec2-dns-name" {
  value = aws_instance.sahar-ec2.public_dns
  
}
# resource "aws_s3_bucket" "sahar-s3" {
#   bucket = "sahar-state-file"

#   tags = {
#     Name = "sahar-state-bucket"
#   }
# }