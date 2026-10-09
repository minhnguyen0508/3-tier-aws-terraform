#!/bin/bash
dnf install -y nginx

cat > /etc/nginx/default.d/proxy.conf <<'CONF'
location / {
    proxy_pass http://${app_alb_dns};
}
CONF

systemctl enable --now nginx