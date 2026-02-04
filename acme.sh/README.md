# acme.sh

This document is a collection of important information from the original `acme.sh` [documentation]( https://github.com/acmesh-official/acme.sh/wiki).

## Content

- [Installation](#installation)

## Installation

> ℹ️ **Information:** The following instructions use `Hetzner DNS` for validation. Check [here](https://github.com/acmesh-official/acme.sh/wiki/dnsapi) for your provider.

First, create the necessary directories for storing SSL certificates and acme.sh configuration files.

```sh
# ToDo: Change domain name
sudo mkdir -p /etc/nginx/certs/example.com
sudo mkdir -p /usr/local/lib/acme.sh
sudo mkdir -p /etc/acme.sh/dnsapi
sudo chmod 700 /etc/acme.sh
```

Next, download and install acme.sh along with the Hetzner DNS API plugin for automatic DNS validation.

```sh
sudo curl -O https://raw.githubusercontent.com/acmesh-official/acme.sh/master/acme.sh

# ToDo: Change mail address
sudo sh acme.sh --install --home /usr/local/lib/acme.sh --config-home /etc/acme.sh --accountmail mail@example.com --log /var/log/acme.sh.log

sudo curl -L -o /usr/local/lib/acme.sh/dnsapi/dns_hetznercloud.sh https://raw.githubusercontent.com/acmesh-official/acme.sh/master/dnsapi/dns_hetznercloud.sh

source ~/.bashrc
```

Now, issue a new SSL certificate using DNS validation with your Hetzner Cloud API token.

```sh
export HETZNER_Token="<token>"

# ToDo: Change domain name (2x)
/usr/local/lib/acme.sh/acme.sh --issue --dns dns_hetznercloud -d example.com -d '*.example.com'  --server letsencrypt --ecc

# ToDo: Change domain name (3x)
/usr/local/lib/acme.sh/acme.sh --install-cert -d example.com --ecc \
--fullchain-file /etc/nginx/certs/example.com/fullchain.pem \
--key-file /etc/nginx/certs/example.com/key.pem \
--reloadcmd "systemctl reload nginx"
```

Finally, add the following SSL certificate paths to your Nginx server configuration.

```sh
ssl_certificate /etc/nginx/certs/example.com/fullchain.pem;
ssl_certificate_key /etc/nginx/certs/example.com/key.pem;
```