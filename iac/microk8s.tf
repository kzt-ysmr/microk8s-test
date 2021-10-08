
# Variables
variable "profile" {}
variable "region" {}

# Constants
locals {
  proj = "microk8s"
}

# Profile Settings
provider "aws" {
  profile = "${var.profile}"
  region = "${var.region}"
}
