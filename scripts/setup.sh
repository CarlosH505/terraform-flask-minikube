#!/bin/bash

# Inicie o Minikube
minikube start, minikube start --driver=docker

# Configure o Docker do Minikube como o Docker padrão
docker run -d -p 5000:5000 --restart=always --name registry registry:2
eval $(minikube docker-env)

# Construa a imagem Docker
docker build -t app-oi-mundo:latest ./app
docker tag app-oi-mundo:latest localhost:5000/app-oi-mundo:latest
docker push localhost:5000/app-oi-mundo:latest

# Aplique as configurações do Terraform
cd terraform
terraform init
terraform apply -auto-approve