#!/bin/bash

# Run as sudo

# Install docker
apt update -y
install docker.io -y

# Deploy Postgres DB

docker run --name postgres-db -e POSTGRES_USER=$postgres_user -e POSTGRES_PASSWORD=$postgres_pwd -e POSTGRES_DB=keycloak -d postgres

# Deploy keycloak

docker run -p $exposed_port:8080 -e KEYCLOAK_ADMIN=$keycloak_user -e KEYCLOAK_ADMIN_PASSWORD=$keycloak_pwd -e KC_DB=$kc_db -e KC_HOSTNAME=$kc_hostname -e KC_DB_PASSWORD=$postgres_pwd -e KC_DB_USERNAME=$postgres_user quay.io/keycloak/keycloak:20.0.1 start
