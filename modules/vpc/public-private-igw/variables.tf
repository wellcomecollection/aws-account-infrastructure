variable "name" {}

variable "cidr_block_vpc" {}

variable "cidr_block_public" {
  type = object({
    prefix  = string
    newbits = number
  })
}

variable "cidr_block_private" {
  type = object({
    prefix  = string
    newbits = number
  })
}

variable "enable_dns_support" {
  default = true
}

variable "enable_dns_hostnames" {
  default = true
}
