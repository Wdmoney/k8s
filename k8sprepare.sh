#!/usr/bin/bash
apt-get install -y apt-transport-https ca-certificates curl gpg chrony
timedatectl set-timezone Europe/Moscow
rm /etc/apt/keyrings/kubernetes-apt-keyring.gpg
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl
systemctl enable --now kubelet
echo -e 'overlay\n' > /etc/modules-load.d/containerd.conf
echo -e 'br_netfilter' >> /etc/modules-load.d/containerd.conf
echo -e 'net.bridge.bridge-nf-call-ip6tables = 1\n' > /etc/sysctl.d/kubernetes.conf
echo -e 'net.bridge.bridge-nf-call-iptables = 1' >> /etc/sysctl.d/kubernetes.conf
echo -e 'net.ipv4.ip_forward = 1' >> /etc/sysctl.d/kubernetes.conf
sysctl --system
