# UFW

This document is a shortened form of the original `UFW` [documentation](https://wiki.ubuntuusers.de/ufw/).

## Content

- [Installation](#installation)
- [Add rule](#add-rule)
- [Delete rule](#delete-rule)

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

## Add Rule

For the full rule guide go [here](https://wiki.ubuntuusers.de/ufw/#Firewall-Regeln).

### 1. New rule

| Options  | Description     |
| -------- | --------------- |
| `allow`  | No restrictions |
| `limit`  | Rate-limits     |
| `deny`   | Silent drop     |
| `reject` | Explicit refuse |


```sh
# ToDo: Set option and port
sudo ufw <option> <port>
```

### 2. Reload

```sh
sudo ufw reload
```

### 3. Check status

```sh
sudo ufw status verbose
```

## Delete Rule

### 1. Show rules

```sh
sudo ufw status numbered
```

### 2. Delete rule

```sh
sudo ufw delete <number>
```
