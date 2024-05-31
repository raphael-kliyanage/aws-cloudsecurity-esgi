# Debian 11 Bullseye
data "aws_ami" "debian_11" {
  most_recent = true
  owners      = ["136693071363"]
  filter {
    name   = "name"
    values = ["debian-11-amd64-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "kungfu_key" {
  key_name   = "tf-${var.instance_name}-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCbwYrUlaGhORKNmnopt+IGkDhWV5locytSs+uNZztbrc8+8R4m68yheTOLe5t0JJx1DzmODfFu00PyIcUCx3eAPB3aYcOznCAg50Cu1rqyU9NMeiyV+24Mei9kMGHUVffe7eYor2MgSlCJ8GtPApdTvTBJLxbkVNKoLsLw5EJTLL0OXvPEXW8KvJ3bMkYgGClAuDMEvg0jsHlmHVqOEpvnq0T5hJ8rzAa+kT24yc7PUqT/nKr66I65zWpkhoCavBaOgMIVz0tEOmpkw0d8sjRJBUZcOxjmUQDMw+2wsQMCkmK5jSOFOG6AMnUr99WTcqzjl0yp7g37l70hvf+uGmtR"
}

resource "aws_iam_instance_profile" "kungfu_profile" {
  name = "tf-${var.instance_name}-instance-profile"
  role = aws_iam_role.kungfu_role.name
}

resource "aws_instance" "kungfu_ec2" {
  ami                    = data.aws_ami.debian_11.id
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.vpc_security_group.ids]
  key_name               = aws_key_pair.kungfu_key.id
  iam_instance_profile   = aws_iam_instance_profile.kungfu_profile.name
  user_data              = file("${path.module}/scripts/install_lab.sh")
  root_block_device {
    delete_on_termination = true
  }
  metadata_options {
   http_tokens   = "required"
   http_endpoint = "enabled"
  }
  tags = {
    Name = "tf-${var.instance_name}-ec2"
  }
}

resource "aws_eip" "nat-eip" {
 vpc  = true

 tags = {
 Name = "${var.nat_eip}"
 }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.kungfu_ec2.id
  allocation_id = aws_eip.nat-eip.id
}
