resource "aws_ecr_repository" "propesq" {
  name                 = "propesqweb_ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
 }
  
  tags = {
   Env = "prod"
 }

}

resource "aws_ecr_repository" "geoserver" {
  name                 = "geoserver_ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
 }
  
  tags = {
   Env = "prod"
 }

}
