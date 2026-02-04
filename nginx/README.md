# Nginx

This document is a collection of important information from the original `Nginx` [documentation]( https://docs.nginx.com).

## Content

- [Installation](#installation)
- [Add Subdomain](#add-subdomain)

## Installation

For the full official guide go [here](https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-open-source).

### 1. Download

Install the Nginx web server package from the official repositories.

```sh
sudo apt install nginx -y
```

### 2. Copy configs

Copy the configuration files from this repository to the Nginx configuration directory.

- [`nginx/conf.d/`](/nginx/conf.d/) -> `/etc/nginx/conf.d`
- [`nginx/sites-available`](/nginx/sites-available/) -> `/etc/nginx/sites-available`

### 3. Enable sites

Create symbolic links only for the sites you want to activate. Only linked sites will be served by Nginx.

```sh
# ToDo: Replace domain
sudo ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/example.com
```

### 4. Reload

Apply the new configuration by reloading the Nginx service.

```sh
sudo systemctl reload nginx
```

## Add Subdomain

### 1. Add new config

Create a new configuration file in `/etc/nginx/sites-available/` named after your subdomain (e.g., `sub.example.com`).

```nginx
server {
	listen 80;
	listen [::]:80;
	server_name sub.example.com; # ToDo: replace domain

	location / {
		return 301 https://$server_name$request_uri;
	}
}

server {
	listen 443 ssl;
	listen [::]:443 ssl;
	server_name sub.example.com; # ToDo: Replace domain

	# ToDo: Replace domain (2x)
	ssl_certificate /etc/nginx/certs/sub.example.com/fullchain.pem;
	ssl_certificate_key /etc/nginx/certs/sub.example.com/key.pem;

	location / {
		proxy_pass http://127.0.0.1:8080; # ToDo: Replace port
		proxy_set_header Host $host;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_set_header X-Forwarded-Proto $scheme;
	}
}
```

### 2. Enable site

Create a symbolic link to activate the new subdomain configuration.

```sh
# ToDo: Replace domain
sudo ln -s /etc/nginx/sites-available/sub.example.com /etc/nginx/sites-enabled/sub.example.com
```