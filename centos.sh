#!/bin/bash -e

# Set up prerequisites
yum install -y curl git make ruby-devel libxml2-devel libxslt-devel epel-release

curl -L "https://raw.githubusercontent.com/metanorma/plantuml-install/master/centos.sh" | bash

# Install latexml
yum install -y perl-core
yum groupinstall -y 'Development Tools'
command -v cpanm >/dev/null 2>&1 || {
  curl -L http://cpanmin.us | perl - App::cpanminus
}

cpanm --notest LaTeXML@0.8.3

# Install idnits & xml2rfc

command -v python3 >/dev/null 2>&1 || {
  yum -y install --enablerepo="epel" python36
}

python3 -m pip install --upgrade pip
python3 -m pip install idnits xml2rfc --ignore-installed six chardet