module "ec2_instance" {
<<<<<<< HEAD
  source                 = "./ec2_instance"
  my_ip                  = chomp(data.http.myip.body)
  instance_name          = "kungfu"
  vpc_id                 = module.vpc.vpc_id
  subnet_id              = module.vpc.subnet_id
  vpc_security_group_ids = module.vpc.vpc_security_group_ids
  nat_eip                = "NAT EIP"
=======
  source        = "./ec2_instance"
  my_ip         = chomp(data.http.myip.body)
  instance_name = "kungfu"
>>>>>>> efc1acb6c6fe3e375c521cbaae20336a68d57d2d
}

module "s3_bucket" {
  source                        = "./s3_bucket"
<<<<<<< HEAD
  bucket_name                   = "groupe1-5si1-esgi-2024-mthouvenin"
=======
  bucket_name                   = "groupe1-5si1-esgi-2024-rkl"
>>>>>>> efc1acb6c6fe3e375c521cbaae20336a68d57d2d
  very_secret_access_key_id     = module.iam.access_key_id
  very_secret_access_key_secret = module.iam.access_key_secret
  very_secret_username          = module.iam.username
}

module "iam" {
  source      = "./iam"
  username    = "kungfu"
  policy_name = "kungfu"
}

<<<<<<< HEAD
module "vpc" {
 source             = "./vpc"
 public_subnet      = "Public Subnet"
 private_subnet     = "Private Subnet"
 internet_gateway   = "Internet Gateway"
 public_route_table = "Public Route Table"
 name_vpc_groupe1   = "Groupe 1 5SI1 VPC"
=======
module "kms" {
  source     = "./kms"
  ressource  = "groupe1-5si1-esgi-2024-rkl-kms"
>>>>>>> efc1acb6c6fe3e375c521cbaae20336a68d57d2d
}

data "http" "myip" {
  url = "https://ifconfig.me"
}
