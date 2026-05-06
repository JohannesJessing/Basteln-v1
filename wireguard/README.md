# WireGuard

This document is a shortened form of the original `WireGuard` [documentation](https://www.wireguard.com/quickstart/).

## Content

- [Requirements](#requirements)
- [Installation on VPS](#installation)
- [Install on Sites](#install-on-sites)
- [Install on NAS](#install-on-nas)
- [Install on Client](#install-on-client)

## Requirements

### VPS

| Requirement   | Description                         |
| ------------- | ----------------------------------- |
| Open Port     | UDP port `51820` must be accessible |
| Public IP     | Static public IP or domain          |
| IP Forwarding | Required on VPS                     |

### Sites

| Requirement   | Description               |
| ------------- | ------------------------- |
| IP Forwarding | Required on site gateways |

### Network Overview

This setup uses a hub-and-spoke topology with the VPS as central hub.

| Node        | WireGuard IP                    | Local Network                     |
| ----------- | ------------------------------- | --------------------------------- |
| VPS (Hub)   | `10.0.0.1/24`, `fd00:1::1/64`   | -                                 |
| first-site  | `10.0.0.2/24`, `fd00:1::2/64`   | `192.168.0.0/24`, `fd00:0::/64`   |
| second-site | `10.0.0.3/24`, `fd00:1::3/64`   | `192.168.10.0/24`, `fd00:10::/64` |
| NAS         | `10.0.0.10/24`, `fd00:1::10/64` | -                                 |
| client      | `10.0.0.20/24`, `fd00:1::20/64` | -                                 |

## Installation on VPS

### 1. Install WireGuard

```sh
sudo apt install wireguard -y
```

### 2. Generate all keys centrally on the VPS

```sh
sudo install -d -m 700 /etc/wireguard/keys

for node in vps first-site second-site nas client; do
  sudo sh -c "cd /etc/wireguard/keys && wg genkey | tee $node.privatekey | wg pubkey > $node.publickey && wg genpsk > $node.presharedkey"
done
```

### 3. Copy configuration

Create `/etc/wireguard/wg0.conf` on **VPS**:

```sh
sudo nano /etc/wireguard/wg0
```

[`wireguard/wg0.conf`](/wireguard/wg0.conf):
```ini
# SET ALL KEYS
[Interface]
Address = 10.0.0.1/24, fd00:1::1/64
ListenPort = 51820
PrivateKey = VPS_PRIVATE_KEY

PostUp = sysctl -w net.ipv4.ip_forward=1
PostUp = sysctl -w net.ipv6.conf.all.forwarding=1

[Peer]
PublicKey = FIRST_SITE_PUBLIC_KEY
PresharedKey = FIRST_SITE_PSK
AllowedIPs = 10.0.0.2/32, fd00:1::2/128, 192.168.0.0/24, fd00:0::/64

[Peer]
PublicKey = SECOND_SITE_PUBLIC_KEY
PresharedKey = SECOND_SITE_PSK
AllowedIPs = 10.0.0.3/32, fd00:1::3/128, 192.168.10.0/24, fd00:10::/64

[Peer]
PublicKey = NAS_PUBLIC_KEY
PresharedKey = NAS_PSK
AllowedIPs = 10.0.0.10/32, fd00:1::10/128

[Peer]
PublicKey = CLIENT_PUBLIC_KEY
PresharedKey = CLIENT_PSK
AllowedIPs = 10.0.0.20/32, fd00:1::20/128
```

### 4. Set permissions

```sh
sudo chmod 600 /etc/wireguard/wg0.conf
```

### 5. Start WireGuard

```sh
sudo systemctl enable --now wg-quick@wg0
```

### 6. Check Status

```sh
sudo wg show
```

## Install on Sites

### 1. Install WireGuard on each site

```sh
sudo apt install wireguard -y
```

### 2. Create site configuration

[`wireguard/first-site.conf`](/wireguard/first-site.conf):
```ini
[Interface]
Address = 10.0.0.2/24, fd00:1::2/64
PrivateKey = FIRST_SITE_PRIVATE_KEY

PostUp = sysctl -w net.ipv4.ip_forward=1
PostUp = sysctl -w net.ipv6.conf.all.forwarding=1

[Peer]
PublicKey = VPS_PUBLIC_KEY
PresharedKey = FIRST_SITE_PSK
Endpoint = example.com:51820
AllowedIPs = 10.0.0.0/24, fd00:1::/64, 192.168.10.0/24, fd00:10::/64
PersistentKeepalive = 25
```

[`wireguard/second-site.conf`](/wireguard/second-site.conf):
```ini
[Interface]
Address = 10.0.0.3/24, fd00:1::3/64
PrivateKey = SECOND_SITE_PRIVATE_KEY

PostUp = sysctl -w net.ipv4.ip_forward=1
PostUp = sysctl -w net.ipv6.conf.all.forwarding=1

[Peer]
PublicKey = VPS_PUBLIC_KEY
PresharedKey = SECOND_SITE_PSK
Endpoint = example.com:51820
AllowedIPs = 10.0.0.0/24, fd00:1::/64, 192.168.0.0/24, fd00:0::/64
PersistentKeepalive = 25
```

### 3. Set permissions

```sh
sudo chmod 600 /etc/wireguard/wg0.conf
```

### 4. Start WireGuard on site

```sh
sudo systemctl enable --now wg-quick@wg0
```

## Install on NAS

[`wireguard/nas.conf`](/wireguard/nas.conf):
```ini
[Interface]
Address = 10.0.0.10/24, fd00:1::10/64
PrivateKey = NAS_PRIVATE_KEY

[Peer]
PublicKey = VPS_PUBLIC_KEY
PresharedKey = NAS_PSK
Endpoint = example.com:51820
AllowedIPs = 10.0.0.0/24, fd00:1::/64, 192.168.10.0/24, fd00:10::/64
PersistentKeepalive = 25
```

## Install on Client

[`wireguard/client.conf`](/wireguard/client.conf):
```ini
[Interface]
Address = 10.0.0.20/24, fd00:1::20/64
PrivateKey = CLIENT_PRIVATE_KEY

[Peer]
PublicKey = VPS_PUBLIC_KEY
PresharedKey = CLIENT_PSK
Endpoint = example.com:51820
AllowedIPs = 10.0.0.0/24, fd00:1::/64, 192.168.0.0/24, fd00:0::/64, 192.168.10.0/24, fd00:10::/64
PersistentKeepalive = 25
```
