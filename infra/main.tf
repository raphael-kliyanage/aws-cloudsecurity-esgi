module "ec2_instance" {
  source           = "./ec2_instance"
  my_ip            = chomp(data.http.myip.body)
  instance_name    = "kungfu"
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
  vpc_security_group_ids = module.vpc.vpc_security_group_ids
}

module "s3_bucket" {
  source                        = "./s3_bucket"
  bucket_name                   = "groupe1-5si1-esgi-2024-llevy"
  very_secret_access_key_id     = module.iam.access_key_id
  very_secret_access_key_secret = module.iam.access_key_secret
  very_secret_username          = module.iam.username
}

module "iam" {
  source      = "./iam"
  username    = "kungfu"
  policy_name = "kungfu"
}

module "vpc" {
  source = "./vpc"
}

data "http" "myip" {
  url = "https://ifconfig.me"
}
