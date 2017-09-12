# Deploy to script.
sudo pip install awsebcli

# Push image to ECS.
docker build -t $IMAGE_NAME .
source ./bin/push-docker.sh

# Deploy to given environment name.
eb deploy $1
