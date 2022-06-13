#!/bin/bash

#set -ex

#Criando o service
kubectl create -f ../yaml_files/service.yaml --save-config

#Criando o deployment
kubectl create -f ../yaml_files/deployment.yaml --save-config

exit 0