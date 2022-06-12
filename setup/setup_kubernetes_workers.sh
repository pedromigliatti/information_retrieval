#Configurando o kubernetes no node master

#Assegurando que o modulo br_netfilter esteja carregado
lsmod | grep br_netfilter >> br_netfilter

#Configurado o net.bridge.bridge-nf-call-iptables do sysctl esteja marcada como 1
cat «EOF | sudo tee /etc/modules-load.d/k8s.conf br_netfilter EOF
cat «EOF | sudo tee /etc/sysctl.d/k8s.conf net.bridge.bridge-nf-callip6tables = 1 net.bridge.bridge-nf-call-iptables = 1 EOF sudo sysctl
–system

#Começando o Deployment
#Desligando o swap da maquina
sudo swapoff –a

#Escolhendo um Hostname unico para Server Node
sudo hostnamectl set-hostname $1

#Configurando o cgroup-driver
sudo -H /bin/bash


#cp /etc/systemd/system/kubelet.service.d/10-kubeadm.conf  /etc/systemd/system/kubelet.service.d/10-kubeadm.bkp
#sed -i 's/--cgroup-driver=systemd/--cgroup-driver=systemd --cgroup-driver=cgroups/'  /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

#Criando o service
#kubectl create -f service.yaml --save-config
#Criando o deployment
#kubectl create -f deployment.yaml --save-config
