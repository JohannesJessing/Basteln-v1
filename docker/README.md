# Docker

This document is a shortened form of the original `Docker` [documentation]( https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository).

## Content

- [Installation](#installation)
  - [1. Detect distribution](#1-detect-distribution)
  - [2. Set up repository](#2-set-up-dockers-apt-repository)
  - [3. Install Docker packages](#3-install-the-docker-packages)
  - [4. Verify install](#4-verify-that-the-docker-engine-installation-is-successful-by-running-the-hello-world-image)
  - [5. Manage access](#5-manage-docker-access)
- [Removal](#removal)
  - [1. Stop services](#1-stop-docker-services)
  - [2. Remove packages](#2-remove-docker-packages)
  - [3. Delete all data](#3-delete-all-data-images-containers-volumes)
  - [4. Cleanup](#4-cleanup)

## Installation

**Note:** There are scripts to install and remove Docker in [`scripts/`](scripts). They run the exact lines from the tutorial below.

### 1. Detect distribution

```sh
if [ -f /etc/os-release ]; then
. /etc/os-release
DISTRO=$ID
else
echo "Unsupported distribution. Exiting."
exit 1
fi
```

### 2. Set up Docker's `apt` repository

```sh
# Add Docker's official GPG key:

sudo apt-get update
sudo apt-get install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/$DISTRO/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc


# Add the repository to Apt sources:

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/$DISTRO \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

### 3. Install the Docker packages

```sh
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
```

### 4. Verify that the Docker Engine installation is successful by running the `hello-world` image

```sh
sudo docker run hello-world
```

### 5. Manage Docker access

**Warning:** This will grant all users of the `docker` group root-level privileges.

The following section is directly copied from the official Docker documentation. For more and detailed information visit their [website](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).

#### 5.1 Create the `docker` group

```sh
sudo groupadd docker
```

#### 5.2 Add your user to the `docker` group

```sh
sudo usermod -aG docker $USER
```

#### 5.3 Activate the changes to groups

```sh
newgrp docker
```

#### 5.4 Verify that you can run `docker` commands without `sudo`

```sh
docker run hello-world
```

## Removal

The following section is directly copied from the official Docker documentation. For more and detailed information visit their [website](https://docs.docker.com/engine/install/ubuntu/#uninstall-docker-engine).

**Note:** There are scripts to install and remove Docker in [`scripts/`](scripts). They run the exact lines from the tutorial below.

### 1. Stop Docker services

```sh
sudo systemctl disable docker.service
sudo systemctl disable containerd.service
```

### 2. Remove Docker packages

```sh
sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras -y
```

### 3. Delete all data (images, containers, volumes)

```sh
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
```

### 4. Cleanup

```sh
sudo apt autoremove -y
```
