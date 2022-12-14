#!/bin/bash

# Run as sudo

# Install docker

sudo apt-get remove docker docker-engine docker.io
sudo apt-get remove docker -y
sudo apt-get remove docker-engine -y
sudo apt-get remove docker.io -y

apt-get update -y
apt-get install docker-ce -y
apt-get install docker-ce-cli -y
apt-get install containerd.io -y
apt-get install docker-compose-plugin -y
apt-get install docker-compose -y

# Deploy Postgres DB

docker run --name postgres-db -e POSTGRES_USER=$postgres_user -e POSTGRES_PASSWORD=$postgres_pwd -e POSTGRES_DB=keycloak -d postgres

# Deploy keycloak

docker run -p $exposed_port:8080 -e KEYCLOAK_ADMIN=$keycloak_user -e KEYCLOAK_ADMIN_PASSWORD=$keycloak_pwd quay.io/keycloak/keycloak:20.0.1 start
