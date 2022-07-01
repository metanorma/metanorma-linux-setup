#!/bin/bash -e

# Set up prerequisites
apt-get install -y curl git

if command -v snap &> /dev/null
then
  snap install yq
  snap install latexml --edge
  snap install metanorma --candidate
else
  apt-get install -y make gcc libxml-libxslt-perl libxml2-dev libxslt-dev libgdbm-dev

  # Install latexml
  command -v latexml >/dev/null 2>&1 || {
    command -v cpanm >/dev/null 2>&1 || {
      curl -L http://cpanmin.us | perl - App::cpanminus
    }
    cpanm --notest XML::LibXSLT@1.96 git://github.com/brucemiller/LaTeXML.git@9a0e7dc5 || true
  }

  # install yq
  command -v yq >/dev/null 2>&1 || {
    curl -o /usr/bin/yq https://github.com/mikefarah/yq/releases/download/3.4.0/yq_linux_amd64 && chmod +x /usr/bin/yq
  }

  # install metanorma gems
  echo "Run 'curl -L \"https://raw.githubusercontent.com/metanorma/metanorma-linux-setup/master/install-gems.sh\" | bash'"
fi

# Install plantuml
curl -L "https://raw.githubusercontent.com/metanorma/plantuml-install/master/ubuntu.sh" | bash

# Install xml2rfc
command -v xml2rfc >/dev/null 2>&1 || {
  apt-get -y install python3-pip python3-setuptools python3-wheel
  pip3 install idnits xml2rfc --ignore-installed six chardet
}
