variable "REGION" {
  default = "ap-south-1"
}

variable "ZONE1" {
  default = "ap-south-1a"
}

variable "AMIS" {
  type = map(any)
  default = {
    ap-south-1 = "ami-0b08bfc6ff7069aff"
    us-east-1  = "ami-0889a44b331db0194"
  }
}

variable "USER" {
  default = "ec2-user"
}