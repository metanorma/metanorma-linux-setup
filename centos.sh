#!/bin/bash -e

# Set up prerequisites
yum install -y curl git make ruby-devel libxml2-devel libxslt-devel epel-release

# Install Java and graphviz
yum install -y java-1.8.0-openjdk graphviz

# Install idnits & xml2rfc
command -v python3 >/dev/null 2>&1 || {
  yum -y install --enablerepo="epel" python36
}

python3 -m pip install --upgrade pip
python3 -m pip install idnits xml2rfc --ignore-installed six chardet