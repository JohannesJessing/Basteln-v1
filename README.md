# Homelab

> ⚠️ **Warning:** This repo is currently under construction.

## Content

- [Services](#services)
  - [acme.sh](#acmesh)
  - [Docker](#docker)
  - [fail2ban](#fail2ban)
  - [Nginx](#nginx)
  - [openSSH](#openssh)
  - [ufw](#ufw)
- [Information](#information)
  - [DNS](#dns)
  - [Domains](#domains)
  - [Ports](#ports)
 
## Services

### acme.sh

> Check [`acme.sh/README.md`](/acme.sh/README.md) for further instructions.

A lightweight shell script for automated SSL certificate management.

| Option    | Value                                                        |
| --------- | ------------------------------------------------------------ |
| Directory | `/etc/acme.sh`, `/usr/local/lib/acme.sh`, `/etc/nginx/certs` |
| Domains   | `all`                                                        |
| Ports     | `not needed`                                                 |
| Config    | `not needed`                                                 |
| Reference | [`GitHub`](https://github.com/acmesh-official/acme.sh)       |

### Docker

> Check [`docker/README.md`](/docker/README.md) for further instructions.

Container platform for running applications in isolated environments.

| Option    | Value                                                                        |
| --------- | ---------------------------------------------------------------------------- |
| Directory | `/etc/docker`, `/var/lib/docker`                                             |
| Domains   | `not needed`                                                                 |
| Ports     | `not needed`                                                                 |
| Config    | [`docker/`](/docker/)                                                        |
| Reference | [`GitHub`](https://github.com/docker), [`Website`](https://docs.docker.com/) |

### fail2ban

> Check [`fail2ban/README.md`](/fail2ban/README.md) for further instructions.

Intrusion prevention tool that bans IPs after failed login attempts.

| Option    | Value                                            |
| --------- | ------------------------------------------------ |
| Directory | `/etc/fail2ban`                                  |
| Domains   | `not needed`                                     |
| Ports     | `not needed`                                     |
| Config    | [`fail2ban/`](/fail2ban/)                        |
| Reference | [`GitHub`](https://github.com/fail2ban/fail2ban) |

### Nginx

> Check [`nginx/README.md`](/nginx/README.md) for further instructions.

High-performance web server and reverse proxy.

| Option    | Value                                                                      |
| --------- | -------------------------------------------------------------------------- |
| Directory | `/etc/nginx`                                                               |
| Domains   | `all`                                                                      |
| Ports     | `80/tcp`, `443/tcp`                                                        |
| Config    | [`nginx/`](/nginx/)                                                        |
| Reference | [`GitHub`](https://github.com/nginx/nginx), [`Website`](https://nginx.org) |

### openSSH

> Check [`openSSH/README.md`](/openSSH/README.md) for further instructions.

Secure remote access via encrypted SSH connections.

| Option    | Value                                                                                         |
| --------- | --------------------------------------------------------------------------------------------- |
| Directory | `/etc/ssh`                                                                                    |
| Domains   | `all`                                                                                         |
| Ports     | `22/tcp`                                                                                      |
| Config    | `not needed`                                                                                  |
| Reference | [`GitHub`](https://github.com/openssh/openssh-portable), [`Website`](https://www.openssh.org) |

### UFW

> Check [`ufw/README.md`](/ufw/README.md) for further instructions.

| Option    | Value                                         |
| --------- | --------------------------------------------- |
| Directory | `/etc/ufw`                                    |
| Domains   | `not needed`                                  |
| Ports     | `all`                                         |
| Config    | [`ufw/`](/ufw/)                               |
| Reference | [`Launchpad`](https://code.launchpad.net/ufw) |

## Information

### DNS

| Record  | Name | Value                    | TTL    |
| ------- | ---- | ------------------------ | ------ |
| `A`     | `@`  | `XXX.XXX.XXX.XXX`        | `3600` |
| `AAAA`  | `@`  | `XXXX:XXXX:XXXX:XXXX::X` | `3600` |
| `CNAME` | `*`  | `example.com.`           | `3600` |

### Domains

| Domain        | Status   | Service |
| ------------- | -------- | ------- |
| `example.com` | `active` | `all`   |

### Ports

| Port      | Status   | Firewall   | Service               |
| --------- | -------- | ---------- | --------------------- |
| `22/tcp`  | `active` | `LIMIT IN` | [`openSSH`](#openssh) |
| `80/tcp`  | `active` | `ALLOW IN` | [`Nginx`](#nginx)     |
| `443/tcp` | `active` | `ALLOW IN` | [`Nginx`](#nginx)     |
