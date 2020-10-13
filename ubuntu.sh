#!/bin/bash -e

# Set up prerequisites
apt-get install -y curl git make gcc ruby-bundler ruby-dev libxml2-dev libxslt-dev

# Install latexml
snap install latexml --edge

# Install yq
snap install yq

# Install xml2rfc
apt-get -y install python3-pip python3-setuptools python3-wheel
pip3 install idnits xml2rfc --ignore-installed six chardet

# Install idnits
export IDNITS_URL=https://tools.ietf.org/tools/idnits/
export IDNITS_VER=$(curl -Ls $IDNITS_URL | grep -e 'tgz' | sed -e 's/.*\(idnits-.*\).tgz.*/\1/') ; echo ${IDNITS_VER}
curl -SL ${IDNITS_URL}${IDNITS_VER} | tar xzv
export PATH=$(pwd)/${IDNITS_VER}:${PATH}

# Setup metanorma
metanorma setup --agree-to-terms || {
  echo "Command 'metanorma setup' finished with errors. Please execute it again before the first metanorma run"
}