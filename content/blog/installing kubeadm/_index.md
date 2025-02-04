---
title: "Installing Kubeadm with Containerd"
weight: 1
draft: false
description: "Manually Installing Kubeadm with Containerd and CNI Plugins"
tags: ["new", "blog"]
series: ["Documentation"]
series_order: 1
---

## Introduction

Kubeadm is a tool that helps set up a Kubernetes cluster with best practices. While Kubernetes distributions often automate the installation, some users prefer a manual setup for better control and customization. This guide will walk you through manually installing kubeadm with containerd and CNI plugins.

## Prerequisites

Before proceeding, ensure you have:

- A Linux-based system (preferably Ubuntu or Debian)
- Root or sudo privileges
- Basic knowledge of Linux and Kubernetes
- Internet access to download dependencies

## Step 1: Install Containerd

Containerd is the container runtime used by Kubernetes. Follow these steps to install it manually:

```sh
wget https://github.com/containerd/containerd/releases/download/v2.0.1/containerd-2.0.1-linux-amd64.tar.gz
tar Cxzvf /usr/local containerd-2.0.1-linux-amd64.tar.gz
```

Once installed, you need to configure and start the containerd service:

```sh
mkdir -p /etc/containerd
containerd config default | tee /etc/containerd/config.toml
systemctl restart containerd
systemctl enable containerd
```

## Step 2: Install Runc

Runc is a command-line tool for spawning and running containers. Install it with the following commands:

```sh
wget https://github.com/opencontainers/runc/releases/download/v1.2.3/runc.amd64
install -m 755 runc.amd64 /usr/local/sbin/runc
```

Verify the installation:

```sh
runc --version
```

## Step 3: Install CNI Plugins

Container Network Interface (CNI) plugins are required to set up networking for Kubernetes pods.

```sh
wget https://github.com/containernetworking/plugins/releases/download/v1.6.1/cni-plugins-linux-amd64-v1.6.1.tgz
mkdir -p /opt/cni/bin
tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.6.1.tgz
```

Confirm that the CNI plugins are installed:

```sh
ls /opt/cni/bin
```

## Step 4: Install Kubernetes Binaries (kubeadm, kubelet, and kubectl)

Now, install the required Kubernetes components:

```sh
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt install -y kubeadm kubelet kubectl
```

Prevent automatic updates that might break compatibility:

```sh
sudo apt-mark hold kubeadm kubelet kubectl
```

## Step 5: Initialize the Kubernetes Cluster

Once all dependencies are installed, you can initialize the Kubernetes cluster using kubeadm:

```sh
sudo kubeadm init --pod-network-cidr=192.168.0.0/16
```

After initialization, set up the kubeconfig file for the current user:

```sh
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

## Step 6: Install a CNI Network Plugin

For pod networking, install a CNI plugin such as Calico or Flannel. For example, to install Calico:

```sh
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
```

## Conclusion

You have successfully installed Kubernetes manually using kubeadm with containerd as the container runtime and CNI plugins for networking. This setup provides better control over the Kubernetes installation and is ideal for advanced users who want to fine-tune their clusters.

## Next Steps

- Deploy applications on the Kubernetes cluster
- Configure additional nodes
- Set up monitoring and logging solutions
