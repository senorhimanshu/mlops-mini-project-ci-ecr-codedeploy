#!/bin/bash
# Login to AWS ECR
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 375756731035.dkr.ecr.ap-south-1.amazonaws.com

# Pull the latest image
docker pull 375756731035.dkr.ecr.ap-south-1.amazonaws.com/himanshu-ecr:v7

# Check if the container 'himanshu-app' is running
if [ "$(docker ps -q -f name=himanshu-app)" ]; then
    # Stop the running container
    docker stop himanshu-app
fi

# Check if the container 'himanshu-app' exists (stopped or running)
if [ "$(docker ps -aq -f name=himanshu-app)" ]; then
    # Remove the container if it exists
    docker rm himanshu-app
fi

# Run a new container
docker run -d -p 80:5000 --name himanshu-app 375756731035.dkr.ecr.ap-south-1.amazonaws.com/himanshu-ecr:v7