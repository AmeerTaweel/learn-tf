resource "aws_key_pair" "tf" {
  key_name = "HOUOUIN-KYOUMA-DA"
  public_key = file("./aws.pub")
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name = aws_key_pair.tf.key_name
  associate_public_ip_address = true  # Explicitly set

  vpc_security_group_ids = [
    module.public_sg.security_group_id
  ]

  subnet_id = module.vpc.public_subnets[0]

  tags = {
    Name = "HelloWorld"
    # Tenant = "MaxMar
  }
}

data "aws_availability_zones" "available" {
}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.15.0"
  name = "main-vpc"
  cidr = "10.0.0.0/16"
  azs = data.aws_availability_zones.available.names
  private_subnets = ["10.0.1.0/24"]
  public_subnets = ["10.0.101.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
}

module "public_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"
  vpc_id = module.vpc.vpc_id
  name = "public_sg"

  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules = ["http-80-tcp", "https-443-tcp"]
  egress_rules = ["all-all"]
  ingress_with_cidr_blocks = [
    {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}
