# WireGuard

This document is a shortened form of the original `WireGuard` [documentation](https://www.wireguard.com/quickstart/).

## Content

- [Requirements](#requirements)
- [Installation](#installation)
- [Add Site](#add-site)
- [Add Client](#add-client)

## Requirements

| Requirement | Description |
| ----------- | ----------- |
| Open Port | UDP port `51820` must be accessible |
| Public IP | VPS needs a static public IP or domain |
| IP Forwarding | Required on VPS and site gateways |

### Network Overview

This setup uses a hub-and-spoke topology with the VPS as central hub.

| Node | WireGuard IP | Local Network |
| ---- | ------------ | ------------- |
| VPS (Hub) | `10.0.0.1/24`, `fd00:1::1/64` | - |
| first-site | `10.0.0.2/24`, `fd00:1::2/64` | `192.168.10.0/24`, `fd00:10::/64` |
| second-site | `10.0.0.3/24`, `fd00:1::3/64` | `192.168.20.0/24`, `fd00:20::/64` |
| client | `10.0.0.10/24`, `fd00:1::10/64` | - |

## Installation

### 1. Install WireGuard

```sh
sudo apt install wireguard -y
```

### 2. Generate keys

```sh
wg genkey | tee privatekey | wg pubkey > publickey
wg genpsk > presharedkey
```

### 3. Copy configuration

Copy the appropriate configuration file to the WireGuard directory.

- VPS: [`wireguard/wg0.conf`](/wireguard/wg0.conf) -> `/etc/wireguard/wg0.conf`
- Site: [`wireguard/first-site.conf`](/wireguard/first-site.conf) -> `/etc/wireguard/wg0.conf`
- Client: [`wireguard/client.conf`](/wireguard/client.conf) -> `/etc/wireguard/wg0.conf`

### 4. Set permissions

```sh
sudo chmod 600 /etc/wireguard/wg0.conf
```

### 5. Start WireGuard

```sh
sudo systemctl enable --now wg-quick@wg0
```

### 6. Verify connection

```sh
sudo wg show
```

## Add Site

### 1. Generate keys on the new site

```sh
wg genkey | tee privatekey | wg pubkey > publickey
wg genpsk > presharedkey
```

### 2. Create site configuration

Create `/etc/wireguard/wg0.conf` on the new site:

```ini
[Interface]
# ToDo: Replace with unique WireGuard IP
Address = 10.0.0.X/24, fd00:1::X/64
PrivateKey = SITE_PRIVATE_KEY

PostUp = sysctl -w net.ipv4.ip_forward=1
PostUp = sysctl -w net.ipv6.conf.all.forwarding=1

[Peer]
PublicKey = VPS_PUBLIC_KEY
PresharedKey = SITE_PSK
# ToDo: Replace with VPS domain/IP
Endpoint = example.com:51820
# ToDo: Add other site networks to AllowedIPs
AllowedIPs = 10.0.0.0/24, fd00:1::/64
PersistentKeepalive = 25
```

### 3. Add peer to VPS

Add the following section to `/etc/wireguard/wg0.conf` on the VPS:

```ini
[Peer]
PublicKey = SITE_PUBLIC_KEY
PresharedKey = SITE_PSK
# ToDo: Replace X with site WireGuard IP, add local network
AllowedIPs = 10.0.0.X/32, fd00:1::X/128, 192.168.X.0/24, fd00:X::/64
```

### 4. Reload WireGuard on VPS

```sh
sudo systemctl restart wg-quick@wg0
```

### 5. Update other sites

Add the new site's local network to `AllowedIPs` on all other sites that need access.

## Add Client

### 1. Generate keys on the client

```sh
wg genkey | tee privatekey | wg pubkey > publickey
wg genpsk > presharedkey
```

### 2. Create client configuration

Create `/etc/wireguard/wg0.conf` on the client:

```ini
[Interface]
# ToDo: Replace with unique WireGuard IP
Address = 10.0.0.X/24, fd00:1::X/64
PrivateKey = CLIENT_PRIVATE_KEY

[Peer]
PublicKey = VPS_PUBLIC_KEY
PresharedKey = CLIENT_PSK
# ToDo: Replace with VPS domain/IP
Endpoint = example.com:51820
# ToDo: Add networks you want to access
AllowedIPs = 10.0.0.0/24, fd00:1::/64, 192.168.10.0/24, fd00:10::/64, 192.168.20.0/24, fd00:20::/64
PersistentKeepalive = 25
```

### 3. Add peer to VPS

Add the following section to `/etc/wireguard/wg0.conf` on the VPS:

```ini
[Peer]
PublicKey = CLIENT_PUBLIC_KEY
PresharedKey = CLIENT_PSK
# ToDo: Replace X with client WireGuard IP
AllowedIPs = 10.0.0.X/32, fd00:1::X/128
```

### 4. Reload WireGuard on VPS

```sh
sudo systemctl restart wg-quick@wg0
```