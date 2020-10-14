#!/bin/bash -e

# Set up prerequisites
apt-get install -y curl git

if command -v snap &> /dev/null
then
  snap install latexml --edge
  snap install yq
  snap install metanorma --devmode --beta
else
  # Install latexml
  command -v cpanm >/dev/null 2>&1 || {
    curl -L http://cpanmin.us | perl - App::cpanminus
  }
  cpanm --notest git://github.com/brucemiller/LaTeXML.git@9a0e7dc5

  # install yq
  curl -o /usr/bin/yq https://github.com/mikefarah/yq/releases/download/3.4.0/yq_linux_amd64 && chmod +x /usr/bin/yq

  # install metanorma gems
  echo "Run 'curl -L \"https://raw.githubusercontent.com/metanorma/metanorma-linux-setup/master/install-gems.sh\" | bash'"
fi

# Install plantuml
curl -L "https://raw.githubusercontent.com/metanorma/plantuml-install/master/ubuntu.sh" | bash

# Install xml2rfc
apt-get -y install python3-pip python3-setuptools python3-wheel
pip3 install idnits xml2rfc --ignore-installed six chardet

# Install idnits
export IDNITS_URL=https://tools.ietf.org/tools/idnits/
export IDNITS_VER=$(curl -Ls $IDNITS_URL | grep -e 'tgz' | sed -e 's/.*\(idnits-.*\).tgz.*/\1/') ; echo ${IDNITS_VER}
curl -SL ${IDNITS_URL}${IDNITS_VER} | tar xzv
export PATH=$(pwd)/${IDNITS_VER}:${PATH}