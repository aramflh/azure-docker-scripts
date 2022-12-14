#!/bin/bash

# Run as sudo

# Install docker
apt-get remove docker -y
apt-get remove docker-engine d -y
apt-get remove docker.io -y
apt-get remove containerd -y
apt-get remove runc -y

apt-get update -y

apt-get install ca-certificates -y
apt-get install curl -y
apt-get install gnupg -y
apt-get install lsb-release -y

mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg |  gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -y

apt-get install docker-ce -y
apt-get install docker-ce-cli -y
apt-get install containerd.io -y
apt-get install docker-compose-plugin -y


# Deploy Postgres DB

docker run --name postgres-db -e POSTGRES_USER=$postgres_user -e POSTGRES_PASSWORD=$postgres_pwd -e POSTGRES_DB=keycloak -d postgres

# Deploy keycloak

docker run -p $exposed_port:8080 -e KEYCLOAK_ADMIN=$keycloak_user -e KEYCLOAK_ADMIN_PASSWORD=$keycloak_pwd -e KC_DB=$kc_db -e KC_HOSTNAME=$kc_hostname -e KC_DB_PASSWORD=$postgres_pwd -e KC_DB_USERNAME=$postgres_user quay.io/keycloak/keycloak:20.0.1 start
