variable "name" {
  type = string
}

variable "principals" {
  description = "A list of AWS principals that can assume this role"
  type        = list(string)
}

variable "max_session_duration" {
  description = "The max length for which this role can be used"
  type        = string

  validation {
    condition     = can(regex("^\\d+ hrs?$", var.max_session_duration))
    error_message = "The max_session_duration must be a string like '1 hr' or '2 hrs'."
  }

  default = "1 hr"
}

locals {
  max_session_duration_in_hours = parseint(replace(var.max_session_duration, "/ hrs?/", ""), 10)
  max_session_duration          = 60 * 60 * local.max_session_duration_in_hours
}
