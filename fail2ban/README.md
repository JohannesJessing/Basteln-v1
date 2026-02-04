# Fail2ban

This document is a shortened form of the original `Fail2ban` [documentation](https://github.com/fail2ban/fail2ban/wiki).

## Content

- [Installation](#installation)
- [Configuration](#configuration)

## Installation

```sh
sudo apt install fail2ban -y
```

## Configuration

Copy the jail configuration from this repository to the Fail2ban configuration directory.

- [`fail2ban/jail.d/`](/fail2ban/jail.d/) -> `/etc/fail2ban/jail.d/`

### SSH Jail

The [`ssh.local`](jail.d/ssh.local) configuration enables SSH protection with the following settings:

| Setting    | Value | Description                       |
| ---------- | ----- | --------------------------------- |
| `banaction`| `ufw` | Uses UFW firewall for banning     |
| `maxretry` | `5`   | Failed attempts before ban        |
| `findtime` | `10m` | Time window for counting attempts |
| `bantime`  | `1d`  | Duration of the ban               |

### Apply Configuration

```sh
sudo systemctl restart fail2ban
```