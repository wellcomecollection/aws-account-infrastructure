variable "vpc_id" {
  type = string
}

variable "name" {
  type = string
}

variable "cidr_block" {
  type = object({
    prefix  = string
    newbits = number
  })
}

variable "map_public_ips_on_launch" {
  type    = bool
  default = false
}
