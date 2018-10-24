#!/bin/bash -e

RUBY_VER="${RUBY_VER:-2.5.1}"

if [ -f "/etc/profile.d/rvm.sh" ]; then
  echo "[rvm] Already installed."
else
  echo "[rvm] Installing RVM..."
  curl -sSL https://get.rvm.io | bash
fi

source /etc/profile.d/rvm.sh
rvm use ${RUBY_VER} --install --binary --fuzzy

# Ruby sassc gem depends on rake gem
gem install rake
gem install bundler
gem install nokogiri -v '1.8.4'
gem install metanorma
gem install metanorma-cli
