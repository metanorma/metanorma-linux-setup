#!/bin/bash

RUBY_VER="${RUBY_VER:-2.5.1}"

rvm use ${RUBY_VER} --install --binary --fuzzy

# Ruby sassc gem depends on rake gem
gem install rake
gem install bundler
gem install nokogiri -v '1.8.4'
gem install metanorma
gem install metanorma-cli
