variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "cidr_block" {
  type = object({
    prefix  = string
    newbits = number
  })
}
