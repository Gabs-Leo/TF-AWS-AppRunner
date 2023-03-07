variable "environment" {}
variable "project_name" {}
variable "project_region" {}
variable "internet_gateway_id" {}
variable "vpc_id" {}

variable "is_public" {
    type = bool
    default = true
}
