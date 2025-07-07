#!/bin/bash

echo "🔧 Installing nginx + certbot..."

yum install epel-release -y
yum install nginx -y

systemctl enable nginx
systemctl start nginx

# Install Certbot
yum install certbot python3-certbot-nginx -y

# Setup firewall (optional)
firewall-cmd --add-service=http --permanent
firewall-cmd --add-service=https --permanent
firewall-cmd --reload

# Konfigurasi nginx untuk proxy ke Node.js port 3000
cat > /etc/nginx/conf.d/lusalhi.conf <<EOF
server {
    listen 80;
    server_name lusalhi.online;

    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }
}
EOF

nginx -t && systemctl reload nginx

# Dapatkan SSL
certbot --nginx -d lusalhi.online --non-interactive --agree-tos -m your@email.com

echo "✅ HTTPS aktif di https://lusalhi.online"
