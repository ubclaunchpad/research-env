#!/bin/bash
set -ev

DOCKER_LOGIN=`aws ecr get-login --region us-east-1`
REMOTE=`echo $DOCKER_LOGIN | sed 's|.*https://||'`

aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY

if [[ -z "${CIRCLE_ARTIFACTS}" ]]; then
    eval "$(aws ecr get-login --region us-east-1 --no-include-email)"
else
    eval "$(aws ecr get-login --region us-east-1)"
fi

docker tag $IMAGE_NAME $REMOTE/$IMAGE_NAME:latest
docker push $REMOTE/$IMAGE_NAME:latest

docker logout https://$REMOTE
