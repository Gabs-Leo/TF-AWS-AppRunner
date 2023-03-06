resource "aws_ecs_cluster" "production" {
  lifecycle {
    create_before_destroy = true
  }

  name = "PROD_propesq"

  tags = {
    Env  = "production"
    Name = "production"
  }
}

resource "aws_ecs_service" "propesq" {
  cluster                 = aws_ecs_cluster.production.id
  depends_on              = [aws_iam_role_policy_attachment.ecs]
  desired_count           = 1
  enable_ecs_managed_tags = true
  force_new_deployment    = true

  load_balancer {
    target_group_arn = aws_alb_target_group.prod_propesq.arn
    container_name   = "propesq"
    container_port   = 80
  }

  name            = "prod_propesq"
  task_definition = aws_ecs_task_definition.propesq.arn
}

resource "aws_ecs_task_definition" "propesq" {
  # execution_role_arn       = data.aws_secretsmanager_secret.by-arn.arn
  container_definitions    = file("./scripts/propesq_container_definitions.json")
  family                   = "prod_propesq"
  memory                   = 1024
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  volume {
    name = "propesqweb"
    host_path = "/efs/aws-backup-restore_2022-09-06T00-03-13-832Z/propesqweb"
    
  }
}

data "aws_ecs_task_definition" "propesq" {
  task_definition = aws_ecs_task_definition.propesq.family
}


resource "aws_ecs_service" "geoserver" {
  cluster                 = aws_ecs_cluster.production.id
  depends_on              = [aws_iam_role_policy_attachment.ecs]
  desired_count           = 1
  enable_ecs_managed_tags = true
  force_new_deployment    = true

  load_balancer {
    target_group_arn = aws_alb_target_group.prod_geoserver.arn
    container_name   = "geoserver"
    container_port   = 8080
  }

  name            = "prod_geoserver"
  task_definition = aws_ecs_task_definition.geoserver.arn
}

resource "aws_ecs_task_definition" "geoserver" {
  # execution_role_arn       = data.aws_secretsmanager_secret.by-arn.arn
  container_definitions    = file("./scripts/geoserver_container_definitions.json")
  family                   = "prod_geoserver"
  memory                   = 2048
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  #  "volumes": [
  #   {
  #     "fsxWindowsFileServerVolumeConfiguration": null,
  #     "efsVolumeConfiguration": null,
  #     "name": "geoserver",
  #     "host": {
  #       "sourcePath": "/efs/geoserver"
  #     },
  #     "dockerVolumeConfiguration": null
  #   },
  #   {
  #     "fsxWindowsFileServerVolumeConfiguration": null,
  #     "efsVolumeConfiguration": {
  #       "transitEncryptionPort": null,
  #       "fileSystemId": "fs-e2679e62",
  #       "authorizationConfig": {
  #         "iam": "DISABLED",
  #         "accessPointId": null
  #       },
  #       "transitEncryption": "DISABLED",
  #       "rootDirectory": "/"
  #     },
  #     "name": "efs-geoserver",
  #     "host": null,
  #     "dockerVolumeConfiguration": null
  #   }
  # ]
  volume {
    name = "geoserver"
    host_path =  "/efs/aws-backup-restore_2022-09-06T00-03-13-832Z/geoserver"
  }
}

data "aws_ecs_task_definition" "geoserver" {
  task_definition = aws_ecs_task_definition.geoserver.family
}