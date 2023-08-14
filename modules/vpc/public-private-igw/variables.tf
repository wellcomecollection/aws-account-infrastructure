variable "name" {
  type = string
}

variable "cidr_block_vpc" {
  type = string
}

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
  type    = bool
  default = true
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}
