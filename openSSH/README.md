# OpenSSH

This document is a shortened form of the original `OpenSSH` [documentation](https://www.openssh.com/manual.html).

## Content

- [Installation](#installation)
- [Configuration](#configuration)

## Installation

```sh
sudo apt install openssh-server -y
```

## Configuration

Edit the SSH daemon configuration file.

```sh
sudo nano /etc/ssh/sshd_config
```

### Recommended Settings

| Setting                  | Value | Description                            |
| ------------------------ | ----- | -------------------------------------- |
| `PasswordAuthentication` | `no`  | Disable password login (use keys only) |
| `PubkeyAuthentication`   | `yes` | Enable public key authentication       |
| `MaxAuthTries`           | `3`   | Limit authentication attempts          |


### Apply Configuration

```sh
sudo systemctl restart sshd
```
