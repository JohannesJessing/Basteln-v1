# UFW

This document is a shortened form of the original `UFW` [documentation](https://wiki.ubuntuusers.de/ufw/).

## Content

- [Installation](#installation)
  - [1. Download](#1-download)
  - [2. rsyslog](#2-install-rsyslog)  
  - [3. Logging](#3-set-logging)
  - [4. SSH rule](#4-limit-ssh)
  - [5. Set default](#5-set-default)
  - [6. Enable](#6-enable)
  - [7. Reload](#7-reload)
  - [8. Enable on boot](#8-enable-on-boot)
  - [9. Status](#9-check-status)

## Installation

For the full installation guide go [here](https://wiki.ubuntuusers.de/ufw/#Installation).

### 1. Download

```sh
sudo apt-get install ufw -y
```

### 2. Install rsyslog

This section is a shortened form of the original `rsyslog` [documentation](https://www.rsyslog.com/doc/installation/index.html).

#### 1. Download `rsyslog`

For the full installation guide go [here](https://www.rsyslog.com/doc/installation/index.html).

```sh
sudo apt-get install rsyslog -y
```

#### 2. Start `rsyslog`

```sh
sudo systemctl start rsyslog
```

### 3. Set logging

```sh
sudo ufw logging on
```

### 4. Limit SSH

```sh
sudo ufw limit ssh
```

### 5. Set default

```sh
sudo ufw default deny incoming
sudo ufw default allow outgoing
```

### 6. Enable

```sh
sudo ufw enable
```

### 7. Reload

```sh
sudo ufw reload
```

### 8. Enable on boot

```sh
sudo systemctl enable ufw
sudo systemctl start ufw
```

### 9. Check status

```sh
sudo ufw status verbose
sudo systemctl status ufw
```
