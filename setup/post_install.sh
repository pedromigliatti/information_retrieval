#!/bin/bash

#set -ex

#Criando o service
kubectl create -f ../yaml_file/service.yaml --save-config

#Criando o deployment
kubectl create -f ../yaml_file/deployment.yaml --save-config

exit 0