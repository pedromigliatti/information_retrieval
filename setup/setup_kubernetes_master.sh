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

#cp /etc/systemd/system/kubelet.service.d/10-kubeadm.conf  /etc/systemd/system/kubelet.service.d/10-kubeadm.bkp
#sed -i 's/--cgroup-driver=systemd/--cgroup-driver=systemd --cgroup-driver=cgroups/'  /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

sudo kubeadm reset

#Iniciando o Cluster
sudo kubeadm init --pod-network-cidr=172.23.0.0/16

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# TODO: output to file? fetch only kubeadm command
kubectl apply -f https://raw.githubusercontent.com/antrea-io/antrea/main/build/yamls/antrea.yml
