variable "vpc_id" {}
variable "route_table_id" {}
variable "is_public" {
    type = bool
    default = true
}