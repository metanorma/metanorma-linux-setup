#!/bin/bash -e

RUBY_VER="${RUBY_VER:-2.6.5}"
USE_RVM="${USE_RVM:-true}"

if [ "$USE_RVM" = true ] ; then
  if [ -f "~/.rvm/scripts/rvm" ]; then
    echo "[rvm] Already installed."
  else
    echo "[rvm] Installing RVM..."
    # https://github.com/rvm/rvm/issues/4573#issuecomment-451982076
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
  
    curl -sSL https://get.rvm.io | bash -s stable
  fi
  
  # This is if RVM got installed somewhere else
  if [ -f "~/.rvm/scripts/rvm" ]; then
    source ~/.rvm/scripts/rvm
  fi
  
  rvm use ${RUBY_VER} --install --binary --fuzzy
fi

# Ruby sassc gem depends on rake gem
gem install rake
gem install bundler
gem install nokogiri
gem install metanorma
gem install metanorma-cli