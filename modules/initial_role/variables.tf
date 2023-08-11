variable "name" {
  type = string
}
variable "federated_principal" {
  type = string
}

variable "aws_principal" {
  type = string
}

variable "assumable_roles" {
  description = "A list of IAM role ARNs that this role is allowed to assume"
  type        = list(string)
}

variable "max_session_duration_in_seconds" {
  description = "The max length for which this role can be used"

  type = number
  # 1 hour
  default = 60 * 60
}
