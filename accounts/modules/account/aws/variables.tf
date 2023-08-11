variable "prefix" {}

variable "principals" {
  type = list(string)
}

variable "max_session_duration" {
  type    = string
  default = "1 hr"
}

variable "infra_bucket_arn" {
  type    = string
  default = ""
}

variable "sbt_releases_bucket_arn" {
  type    = string
  default = "arn:aws:s3:::releases.mvn-repo.wellcomecollection.org"
}
