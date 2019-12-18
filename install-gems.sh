#!/bin/bash -e

RUBY_VER="${RUBY_VER:-2.6.5}"

if [ -f "/etc/profile.d/rvm.sh" ]; then
  echo "[rvm] Already installed."
else
  echo "[rvm] Installing RVM..."
  curl -sSL https://get.rvm.io | bash
  usermod -a -G rvm `whoami`
fi

# This is if RVM got installed somewhere else
if [ -f "/etc/profile.d/rvm.sh" ]; then
  source /etc/profile.d/rvm.sh
fi

rvm use ${RUBY_VER} --install --binary --fuzzy

# Ruby sassc gem depends on rake gem
gem install rake
gem install bundler
gem install nokogiri
gem install metanorma
gem install metanorma-cli
