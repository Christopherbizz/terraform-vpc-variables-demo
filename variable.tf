variable region {
  
    default = "us-east-1"
}

variable instance-type {

    default = "t2.micro"
}

variable ami {

    default = "ami-04ff98ccbfa41c9ad"
}

variable key {
    default = "rtp-03"
}

variable vpc-cidr {

    default = "10.10.0.0/16"
}

variable subnet1-cidr {

    default = "10.10.1.0/24"
}
variable az1 {

    default = "us-east-1d"
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH into the instance"
  default     = "YOUR.IP.HERE/32"
}
