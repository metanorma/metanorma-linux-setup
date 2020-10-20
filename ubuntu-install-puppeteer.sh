#!/bin/bash

if npm list -g --depth 0 | grep "[p]uppeteer" > /dev/null 2>&1; then
  echo '[node: puppeteer] Puppeteer already installed.'
  exit 0;
fi

# Install puppeteer
echo '[node: puppeteer] Installing prerequisites...'
command -v npm >/dev/null 2>&1 || { apt-get install -y npm; }

# https://github.com/puppeteer/puppeteer/blob/master/docs/troubleshooting.md#chrome-headless-doesnt-launch-on-unix
apt-get install -y ca-certificates fonts-liberation gconf-service libappindicator1 libasound2 libatk-bridge2.0-0 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgbm1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libnss3 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 lsb-release wget xdg-utils

echo '[node: puppeteer] Installing puppeteer...'
npm install -g --save --save-exact puppeteer@3.0.1 --unsafe-perm=true

echo '[node: puppeteer] Installation complete...'
