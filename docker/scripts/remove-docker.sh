#!/bin/bash

# Stop Docker services
sudo systemctl disable docker.service
sudo systemctl disable containerd.service

# Remove Docker packages
sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras -y

# Delete data
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd

# Cleanup
sudo apt autoremove -y
