variable "private_subnet" {
 type = string
}

variable "public_subnet" {
 type = string
}

variable "internet_gateway" {
 type = string
}

variable "public_route_table" {
 type = string
}

variable "name_vpc_groupe1" {
 type = string
}

variable "kung-fu_ec2_ingress_ports" {
 description = "Allowed kung_fu_ec2_ports"
  type = list(object({
   port        = number
   protocol    = string
   cidr_blocks = list(string)
   }))

  default = [
   {
    port        = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   },

   {
    port        = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   },

   {
    port        = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   }
  ]
 }
