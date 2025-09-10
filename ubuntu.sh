#!/bin/bash -e

# Set up prerequisites
apt install -y curl git

if command -v snap &> /dev/null
then
  snap install yq
  snap install metanorma --candidate
else
  apt install -y make gcc libxml-libxslt-perl libxml2-dev libxslt-dev libgdbm-dev

  # install yq
  command -v yq >/dev/null 2>&1 || {
    curl -o /usr/bin/yq https://github.com/mikefarah/yq/releases/download/3.4.0/yq_linux_amd64 && chmod +x /usr/bin/yq
  }

  # install metanorma gems
  echo "Run 'curl -L \"https://raw.githubusercontent.com/metanorma/metanorma-linux-setup/master/install-gems.sh\" | bash'"
fi

# Install Java
apt --no-install-recommends install -y openjdk-11-jre
apt install -y graphviz

# Install xml2rfc
command -v xml2rfc >/dev/null 2>&1 || {
  apt install -y python3-pip python3-setuptools python3-wheel
  pip3 install idnits xml2rfc --ignore-installed six chardet
}
