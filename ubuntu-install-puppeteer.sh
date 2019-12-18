#!/bin/bash

if npm list -g --depth 0 | \grep [p]uppeteer > /dev/null 2>&1; then
  echo '[node: puppeteer] Puppeteer already installed.'
  exit 0;
fi

# Install puppeteer
echo '[node: puppeteer] Installing prerequisites...'
command -v npm >/dev/null 2>&1 || { apt-get install -y npm; }
apt-get install -y gconf-service gconf-service-backend gconf2-common libdbus-glib-1-2
apt-get install -y libpangocairo-1.0-0 libx11-xcb1 libxcomposite1 libxcursor1 libxdamage1 libxi6 libxtst6 libnss3 libcups2 libxss1 libxrandr2 libgconf2-4 libasound2 libatk1.0-0 libgtk-3-0 libx11-6

echo '[node: puppeteer] Installing puppeteer...'
npm install -g --save --save-exact puppeteer --unsafe-perm=true

echo '[node: puppeteer] Installation complete...'
