#!/bin/bash

# Install Docker
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker $USER

# Install Docker Compose
sudo yum install -y docker-compose-plugin

# Install Airbyte
mkdir /opt/airbyte && cd /opt/airbyte
wget https://raw.githubusercontent.com/airbytehq/airbyte-platform/main/{.env,flags.yml,docker-compose.yaml}
docker compose up -d