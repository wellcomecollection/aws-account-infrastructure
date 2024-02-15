variable "prefix" {
  type = string
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

variable "ami_distribution_account_id" {
  type = string
  # This is the account id of the account that will receive the AMI (default is platform account id)
  default = "760097843905"
}