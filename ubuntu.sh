#!/bin/bash -e

# Set up prerequisites
apt-get install -y curl git make ruby-bundler ruby-dev libxml2-dev libxslt-dev

# Install libsass
if [ -f "/usr/local/lib/libsass.a" ] || [ -f "/usr/lib/libsass.a" ]; then
  echo '[libsass] libsass already installed.'
else
  # If no sassc package, manually install
  # TODO: This install command is not idempotent
  echo '[libsass] Installing libsass...'
  if [ "$(apt-cache search sassc | wc -l)" -eq "0" ]; then
    echo '[libsass] Packaged sassc not available. Compiling libsass...'
    curl \   https://gist.githubusercontent.com/edouard-lopez/503d40a5c1a49cf8ae87/raw/6ee53f102b4ed97e78c356c471ccf82197a89578/libsass-install.bash \
      | bash
  else
    echo '[libsass] Installing package sassc...'
    apt-get install -y sassc
  fi
fi

# Install NVM
if [ ! -d "$HOME/.nvm" ]; then
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
fi

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install node

# Install puppeteer
apt-get install -y gconf-service gconf-service-backend gconf2-common libdbus-glib-1-2
apt-get install -y libpangocairo-1.0-0 libx11-xcb1 libxcomposite1 libxcursor1 libxdamage1 libxi6 libxtst6 libnss3 libcups2 libxss1 libxrandr2 libgconf2-4 libasound2 libatk1.0-0 libgtk-3-0

if npm list -g --depth 0 | \grep [p]uppeteer > /dev/null 2>&1; then
  echo '[node: puppeteer] Puppeteer already installed.'
else
  echo '[node: puppeteer] Installing puppeteer...'
  npm install -g --save --save-exact puppeteer --unsafe-perm=true
fi
export NODE_PATH=$(npm root -g)

curl -L "https://raw.githubusercontent.com/metanorma/plantuml-install/master/ubuntu.sh" | bash
