#!/bin/bash

echo "🚀 Memulai setup VPS untuk Node.js + PM2..."

# 1. Update & install tools
apt update && apt upgrade -y
apt install curl wget git build-essential -y

# 2. Install NVM & Node.js 20
echo "➡️ Menginstall NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Load nvm tanpa logout
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"

echo "➡️ Menginstall Node.js 20"
nvm install 20
nvm use 20
nvm alias default 20

# 3. Install PM2
npm install -g pm2

# 4. Konfirmasi
echo ""
echo "✅ Selesai! Versi terpasang:"
node -v
npm -v
pm2 -v
