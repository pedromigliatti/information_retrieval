#!/bin/bash

#Configurando o kubernetes no node master
# set -ex

# Update system
sudo apt update -y

# Install docker
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

# Install kubernetes
sudo apt install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt install -y kubeadm kubelet kubectl kubernetes-cni

#Assegurando que o modulo br_netfilter esteja carregado
lsmod | grep br_netfilter >> $HOME/br_netfilter

#Configurado o net.bridge.bridge-nf-call-iptables do sysctl esteja marcada como 1
cat << EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF
cat << EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-callip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

#Começando o Deployment
#Desligando o swap da maquina
sudo swapoff -a
sudo cp -f /etc/fstab /etc/fstab.bkp
sudo sed -i 's/^\/swap.img/#\/swap.img/' /etc/fstab

#Escolhendo um Hostname unico para Server Node
# sudo hostnamectl set-hostname $1

yes | sudo kubeadm reset

exit 0
