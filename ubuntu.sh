#!/bin/bash -e

# Set up prerequisites
apt-get install -y curl git make gcc ruby-bundler ruby-dev libxml2-dev libxslt-dev

# Install libsass
if [ -f "/usr/local/lib/libsass.a" ] || [ -f "/usr/lib/libsass.a" ]; then
  echo '[libsass] libsass already installed.'
else
  # If no sassc package, manually install
  # TODO: This install command is not idempotent
  echo '[libsass] Installing libsass...'
  if [ "$(apt-cache search --names-only '^libsass-dev$' | wc -l)" -eq "0" ]; then
    if [ "$(apt-cache search --names-only '^sassc$' | wc -l)" -eq "0" ]; then
      echo '[libsass] Packaged sassc not available. Compiling libsass...'
      curl https://gist.githubusercontent.com/edouard-lopez/503d40a5c1a49cf8ae87/raw/6ee53f102b4ed97e78c356c471ccf82197a89578/libsass-install.bash \
        | bash
    else
      echo '[libsass] Installing package sassc...'
      apt-get install -y sassc
    fi
  else
    echo '[libsass] Installing package libsass-dev...'
    apt-get install -y libsass-dev
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
nvm alias mn-node node
nvm use mn-node

# Install puppeteer
curl -L "https://raw.githubusercontent.com/metanorma/metanorma-linux-setup/master/ubuntu-install-puppeteer.sh" | bash
export NODE_PATH=$(npm root -g)

curl -L "https://raw.githubusercontent.com/metanorma/plantuml-install/master/ubuntu.sh" | bash

# Install latexml
command -v cpanm >/dev/null 2>&1 || {
  curl -L http://cpanmin.us | perl - App::cpanminus
}
if [ -z "$METANORMA_DEBUG" ]; then
  cpanm LaTeXML@0.8.4
else
  cpanm --notest LaTeXML@0.8.4
fi

# Install idnits & xml2rfc
command -v pip >/dev/null 2>&1 || {
  apt-get install -y python-pip
}
pip install --upgrade pip 
pip install idnits xml2rfc --ignore-installed six chardet

export IDNITS_URL=https://tools.ietf.org/tools/idnits/
export IDNITS_VER=$(curl -Ls $IDNITS_URL | grep -e 'tgz' | sed -e 's/.*\(idnits-.*\).tgz.*/\1/') ; echo ${IDNITS_VER}
curl -SL ${IDNITS_URL}${IDNITS_VER} | tar xzv
export PATH=$(pwd)/${IDNITS_VER}:${PATH}

curl -sSL https://github.com/mikefarah/yq/releases/download/2.4.0/yq_linux_amd64 -o /usr/bin/yq && chmod +x /usr/bin/yq