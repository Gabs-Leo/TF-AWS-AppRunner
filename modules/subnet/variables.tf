variable "vpc_id" {}
variable "route_table_id" {}
variable "is_public" {
    type = bool
    default = true
}
variable "cidr" {
  default = "10.10.20.0/24"
}
variable "project_name" {}
variable "environment" {}
variable "project_region" {
  
}