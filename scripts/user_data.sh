#!/bin/bash

echo ECS_CLUSTER=PROD_propesq >> /etc/ecs/ecs.config

sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-0446ad2b235f4d86a.efs.us-east-1.amazonaws.com:/ efs