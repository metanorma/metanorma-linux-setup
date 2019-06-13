#!/bin/bash -e

# Set up prerequisites
yum install -y curl git make ruby-devel libxml2-devel libxslt-devel epel-release

echo '[libsass] Installing package sassc...'
yum install -y libsass

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
yum install -y pango libXcomposite libXcursor libXdamage libXext libXi libXtst cups-libs libXScrnSaver libXrandr GConf2 alsa-lib atk gtk3

# Fonts for puppeteer
yum install -y ipa-gothic-fonts xorg-x11-fonts-100dpi xorg-x11-fonts-75dpi xorg-x11-utils xorg-x11-fonts-cyrillic xorg-x11-fonts-Type1 xorg-x11-fonts-misc

if npm list -g --depth 0 | \grep [p]uppeteer > /dev/null 2>&1; then
  echo '[node: puppeteer] Puppeteer already installed.'
else
  echo '[node: puppeteer] Installing puppeteer...'
  npm install -g --save --save-exact puppeteer --unsafe-perm=true
fi
export NODE_PATH=$(npm root -g)

curl -L "https://raw.githubusercontent.com/metanorma/plantuml-install/master/centos.sh" | bash

# Install latexml
command -v cpanm >/dev/null 2>&1 || {
  curl -L http://cpanmin.us | perl - App::cpanminus
}
if [ -z "$METANORMA_DEBUG" ]; then
  cpanm LaTeXML@0.8.3
else
  cpanm --notest LaTeXML@0.8.3
fi

# Install idnits & xml2rfc

command -v pip >/dev/null 2>&1 || {
  yum install -y python-pip
}

pip install --upgrade pip
pip install idnits xml2rfc --ignore-installed six chardet