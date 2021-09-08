# General
variable "workspace_account" {}
variable "workspace_environment" {}
variable "app_name" {
  default = "akeyless-gateway"
}

variable "region_abbr" {
  type = map
  default = {
    "us-east-1"    = "ue1"
    "us-east-2"    = "ue2"
    "us-west-1"    = "uw1"
    "us-west-2"    = "uw2"
    "eu-central-1" = "ec1"
    "eu-west-1"    = "ew1"
    "eu-west-2"    = "ew2"
    "eu-west-3"    = "ew3"
    "eu-north-1"   = "en1"
  }
}

# Autoscaling Group
variable "instance_type" {
  default = "m5.large"
}

variable "asg_max_size" {
  default = "3"
}

variable "asg_min_size" {
  default = "1"
}

variable "asg_desired_capacity" {
  default = "1"
}

variable "key_name" {}

# Tags
variable "tag_team" {
  type    = string
  default = "DSO"
}

variable "tag_cost_center" {
  type    = string
  default = "ENG"
}

variable "tag_cost_code" {
  type    = string
  default = "SP"
}
