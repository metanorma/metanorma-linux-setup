#!/bin/bash

PLANTUML_URL="${PLANTUML_URL:-http://sourceforge.net/projects/plantuml/files/plantuml.jar/download}"

# Set up prerequisites
apt-get install -y curl git make ruby-bundler ruby-dev libxml2-dev libxslt-dev default-jre sassc

# for puppeteer
apt-get install -y npm
apt-get install -y gconf-service gconf-service-backend gconf2-common libdbus-glib-1-2 libgconf-2-4 libgconf2-4 libxss1
npm i puppeteer

# for plantuml
apt-get install -y graphviz
mkdir -p /opt/plantuml && \
  curl -o /opt/plantuml/plantuml.jar \
  ${PLANTUML_URL}
printf '#!/bin/sh\nexec java -jar /opt/plantuml/plantuml.jar "$@"' > /usr/bin/plantuml.sh
chmod +x /usr/bin/plantuml.sh

# Ruby sassc gem depends on rake gem
gem install rake
gem install bundler
gem install nokogiri -v '1.8.4'
gem install metanorma
gem install metanorma-cli
